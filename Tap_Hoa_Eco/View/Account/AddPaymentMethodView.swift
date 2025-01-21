//
//  AddPaymentMethodView.swift
//  Tap_Hoa_Eco
//
//  Created by Nguyễn Quốc Hiếu on 17/5/24.
//

import SwiftUI

enum ActiveTextField {
    case none, number, name, month, year
}

struct AddPaymentMethodView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var payVM = PaymentViewModel.shared
    @FocusState private var activeField: ActiveTextField?
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack(spacing: 16){
                    ZStack {
                        LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .clipShape(.rect(cornerRadius: 25))
                    }
                    .frame(height: 200)
                    .overlay {
                        CardFrontView
                    }
                    
                    CardTextField(
                        title: DataConstants.Payment.cardNumber.localized,
                        hint: DataConstants.Payment.cardNumberPlaceholder.localized,
                        value: $payVM.txtCardNumber
                    ) {
                        payVM.txtCardNumber = String(payVM.txtCardNumber.group(" ", count: 4).prefix(19))
                    }
                    .focused($activeField, equals: .number)
                    
                    CardTextField(
                        title: DataConstants.Payment.name.localized,
                        hint: DataConstants.Payment.namePlaceholder.localized,
                        value: $payVM.txtName
                    ) {
                        payVM.txtName = payVM.txtName
                    }
                    .focused($activeField, equals: .name)

                    HStack{
                        CardTextField(
                            title: DataConstants.Payment.month.localized,
                            hint: DataConstants.Payment.monthPlaceholder.localized,
                            value: $payVM.txtCardMonth
                        ) {
                            payVM.txtCardMonth = String(payVM.txtCardMonth.prefix(2))
                        }
                        CardTextField(
                            title: DataConstants.Payment.year.localized,
                            hint: DataConstants.Payment.yearPlaceholder.localized,
                            value: $payVM.txtCardYear
                        ) {
                            payVM.txtCardYear = String(payVM.txtCardYear.prefix(4))
                        }
                    }
                    .focused($activeField, equals: .month)
                    
                    RoundButton(title: DataConstants.Payment.addCard.localized) {
                        payVM.serviceCallAdd {
                            dismiss()
                        }
                    }
                    .focused($activeField, equals: .year)
                }
                .padding()
            }
            .background(Color.bgColor)
            .navigationTitle(DataConstants.Payment.title.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(isPresented: $payVM.showError) {
            Alert(
                title: Text(Globs.AppName),
                message: Text(payVM.errorMessage),
                dismissButton: .default(Text(DataConstants.Payment.ok.localized))
            )
        }
    }
    
    @ViewBuilder
    private var CardFrontView: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
                Text(DataConstants.Payment.cardNumber.localized)
                
                Text(String(payVM.rawCardNumber.dummyText("*", count: 16).prefix(16)).group(" ", count: 4))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(10)
            .background(AnimatedRing(activeField == .number))
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(DataConstants.Payment.cardholderName.localized)
                        .font(.caption)
                    
                    Text(payVM.txtName.isEmpty ? "..." : payVM.txtName)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(AnimatedRing(activeField == .name))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(DataConstants.Payment.expires.localized)
                        .font(.caption)
                    
                    HStack(spacing: 4) {
                        Text(String(payVM.txtCardMonth.prefix(2)).dummyText("M", count: 2))
                        Text("/")
                        Text(String(payVM.txtCardYear.prefix(4)).dummyText("Y", count: 4))
                    }
                }
                .frame(maxWidth: 96, alignment: .trailing)
                .padding(10)
                .background(AnimatedRing(activeField == .month || activeField == .year))
            }
            
        }
        .foregroundStyle(.white)
        .monospaced()
        .contentTransition(.numericText())
        .padding(15)
    }
    
    @ViewBuilder
    func AnimatedRing(_ status: Bool) -> some View {
        if status {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 1.5)
                .matchedGeometryEffect(id: "RING", in: animation)
        }
    }
}

extension String {
    func group(_ character: Character, count: Int) -> String {
        var modifiedString = self.replacingOccurrences(of: String(character), with: "")
        
        for index in 0..<modifiedString.count {
            if index % count == 0 && index != 0 {
                let groupCharactersCount = modifiedString.count(where: { $0 == character })
                let stringIndex = modifiedString.index(modifiedString.startIndex, offsetBy: index + groupCharactersCount)
                modifiedString.insert(character, at: stringIndex)
            }
        }
        
        return modifiedString
    }
    
    func dummyText(_ character: Character, count: Int) -> String {
        var tempText = self.replacingOccurrences(of: String(character), with: "")
        let remaining = min(max(count - tempText.count, 0), count)
        
        if remaining > 0 {
            tempText.append(String(repeating: character, count: remaining))
        }
        
        return tempText
    }
}

struct CardTextField: View {
    var title: String
    var hint: String
    @Binding var value: String
    var onChange: () -> ()
    @FocusState private var isActive: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.gray)
            
            TextField("", text: $value, prompt: Text(hint).foregroundColor(Color.textTitle))
                .foregroundStyle(Color.textTitle)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(isActive ? Color.primaryApp : .gray.opacity(0.5), lineWidth: 1.0)
                    .animation(.snappy, value: isActive)
                )
                .focused($isActive)
        }
        .onChange(of: value) { newValue in onChange() }
    }
}

#Preview {
    AddPaymentMethodView()
}

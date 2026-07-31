import SwiftUI

struct AddAlarmView: View {
    @Binding var newTime: Date
    @Binding var isDaily: Bool
    var onConfirm: (Date, Bool) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("选择时间")) {
                    DatePicker(
                        "闹钟时间",
                        selection: $newTime,
                        displayedComponents: [.hour, .minute]
                    )
                }
                
                Section(header: Text("重复选项")) {
                    Toggle("每日重复", isBound: $isDaily)
                }
            }
            .navigationTitle("新增闹钟")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("确定") { onConfirm(newTime, isDaily) }
                }
            }
        }
    }
}

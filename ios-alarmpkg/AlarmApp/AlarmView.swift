import SwiftUI

struct AlarmView: View {
    @ObservedObject var alarmManager: AlarmManager
    
    @State private var showAddAlarm = false
    @State private var newTime = Date()
    @State private var isDaily = true
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(alarmManager.alarms.enumerated()), id: \.0) { index, alarm in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(alarm.label).font(.headline)
                            Text(alarm.time.formatted(.dateTime.hour(.defaultDigit).minute两位))
                                .font(.subheadline).foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }
                .onDelete(perform: alarmManager.deleteAlarm(at:))
            }
            .navigationTitle("⏰ 闹钟")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showAddAlarm = true }) { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $showAddAlarm) {
                AddAlarmView(newTime: $newTime, isDaily: $isDaily) { time, daily in
                    alarmManager.addAlarm(alarm: Alarm(time: time, isDaily: daily))
                    showAddAlarm = false
                }
            }
        }
    }
}

extension Date {
    func formatted(_ style: FormatStyle<Date>) -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .short)
    }
}

struct Alarm {
    let id = UUID()
    var time: Date
    var isDaily: Bool
    var label: String = "闹钟"
}

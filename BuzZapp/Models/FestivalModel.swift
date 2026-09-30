

struct CalendarificResponse: Codable {

    let response: CalendarificData

}

struct CalendarificData: Codable {

    let holidays: [CalendarificHoliday]

}

struct CalendarificHoliday: Codable {

    let name: String

    let date: CalendarificDate

}

struct CalendarificDate: Codable {

    let iso: String

    let datetime: CalendarificDateTime

}

struct CalendarificDateTime: Codable {

    let year: Int

    let month: Int

    let day: Int

}

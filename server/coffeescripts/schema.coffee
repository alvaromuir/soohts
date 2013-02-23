///
  Campaign DB setup
///

module.exports =
  advertiser: String
  program: String
  flight:
    startDate: Date
    endDate: Date
  geoCodes: []
  keywords: []
  active: Boolean
  lastUpdated: Date
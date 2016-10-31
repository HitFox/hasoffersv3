# 0.5.2
- [#54] Added Offer::addGroup method
- [#51] Added Offer::create, Offer::addTargetCountry and Offer::unblockAffiliate methods

# 0.5.1
- [#50] Added Affiliate::update method

# 0.4.0
- [#42] Support "Employee": findAll, find_all_by_ids and find_by_id
- [#41] Added config option `read_timeout` to changed default timeout to 60

# 0.3.0
- [#39] Removed depreacted methods. Updated structure to use separated client configs.

# 0.2.7
- [#37][#38] Support "OfferPixel": findAll, find_all_by_ids, find_by_id, get_allowed_types

# 0.2.6
- Use `https` by default

# 0.2.5
- Support "Application/findAllAffiliateTiers" method

# 0.2.4
- Support "Offer/getTierPayouts" method
- Support "Affiliate/getAffiliateTier" method

# 0.2.3
- Support "Offer/generateTrackingLink" method
- Support "Affiliate/create" method

# 0.2.2
- Support "Offer/findAllIdsByAffiliateId" method
- Support "Affiliate_Offer/findMyOffers" method

# 0.2.1
- Support "Affiliate_Offer/generateTrackingLink" method

# 0.2.0
- Support "Affiliate_Offer": findAll, find_by_id, get_categories, get_target_countries

# 0.1.1
- Support "Offer/getApprovedAffiliateIds" method

# 0.1.0

- [#14] added `.find_added_conversions` and `find_updated_conversions` calls
- [#16] added protocol configuration option for API url (default is `http`)
- [#13] fixed `get_log_expirations` call
- [#15] fixed missing tests for `RawLog`

# 0.0.1

- initial release

## 0.0.2 / Unreleased
### API
- add common response format

### Admin
- CRUD system products and groups
- design product page
- design group page
- add icon for group
- add roles: user and admin

## 0.0.1 / 2014-02-15
### API
- [ENHANCEMENT] system products are available for unauthorized users
- [FEATURE]     add localization for products and groups
- [FEATURE]     include related items into request
                e.g. {title: 'apple', group_id: 1} ~> {..., group: { id: 1, title: 'Fruits' } }
- [FEATURE]     add attribute owner, which displays whether product is user's or system's

### Admin
- [ENHANCEMENT] authorization/authentication using email and password (Devise)
- [ENHANCEMENT] CRUD products and groups
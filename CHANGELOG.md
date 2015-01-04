## 0.0.4 / Unreleased
### API
- add common response format

### Admin
- design product page
- design group page
- add icon for group
- add sorting by system's products and user's

## 0.0.3 / 2014-04-15
### Admin
- add pagination

## 0.0.2 / 2014-03-15
### Admin
- add roles: user, manager, admin
- CRUD system products

## 0.0.1 / 2014-02-15
### API
- system products are available for unauthorized users
- add localization for products and groups
- include related items into request
  e.g. {title: 'apple', group_id: 1} ~> {..., group: { id: 1, title: 'Fruits' } }
- add attribute owner, which displays whether product is user's or system's

### Admin
- authorization/authentication using email and password (Devise)
- CRUD products and groups
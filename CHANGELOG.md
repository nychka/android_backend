## 0.0.5 / Unreleased
### API
- add common response format

### Admin
- design new product page
- design groups page
- design new group page
- add icon for group

## 0.0.4 / 2014-01-05
### Admin
- add search
- add filtering by system products and users'
- updated products page

## 0.0.3 / 2014-01-04
### Admin
- add pagination

## 0.0.2 / 2014-01-03
### Admin
- add roles: user, manager, admin
- CRUD system products

## 0.0.1 / 2014-01-02
### API
- system products are available for unauthorized users
- add localization for products and groups
- include related items into request
  e.g. {title: 'apple', group_id: 1} ~> {..., group: { id: 1, title: 'Fruits' } }
- add attribute owner, which displays whether product is user's or system's

### Admin
- authorization/authentication using email and password (Devise)
- CRUD products and groups
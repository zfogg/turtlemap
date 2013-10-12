module.exports = (match) ->
  match ''                 , 'home#index'

  match 'courses?*query'   , 'courses#search'
  match 'courses'          , 'courses#index'

  match 'buildings?*query' , 'buildings#search'
  match 'buildings'        , 'buildings#index'

  match '*404'             , 'fourOhFour#index'

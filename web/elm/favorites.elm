module Favorites exposing (..)

import Html exposing (..)
import Html.Attributes exposing (alt, class, src)


type alias Favorite =
    { icon : String
    , title : String
    , detail : String
    }


favoriteTech : List Favorite
favoriteTech =
    [ { icon = "/images/ruby100.png"
      , title = "Ruby"
      , detail = "Ruby was my first programming language. When I was deciding which language to start with, I was especially drawn to Ruby's elegant syntax and expressive naming conventions. I don't write much Ruby anymore, but my early exposure to the Ruby community informs the way I write code in general. In particular, Ruby exposed me to great books and talks by object oriented gurus like Sandi Metz, Martin Fowler, and Bob Martin."
      }
    , { icon = "/images/elixir100.png"
      , title = "Elixir"
      , detail = "Elixir is a beautiful functional language. I was first exposed to functional programming through Brian Lonsdorf's \"Mostly Adequate\" JavaScript book and talks, and I chose Elixir to more deeply explore the paradigm. Elixir's pattern matching, macros, and pipes enable really enjoyable ways to write code."
      }
    , { icon = "/images/react100.png"
      , title = "React"
      , detail = "React's declarative approach to UI rendering was a breath of fresh air compared to the direct DOM manipulation that I had been doing previously. I love how quickly the framework gets out of the way, and allows me to get everything done with plain-old JavaScript."
      }
    , { icon = "/images/go100.png"
      , title = "Go"
      , detail = "Go is the first typed language I learned, and I really enjoy how much freedom and confidence the type system lends to code refactoring. I also love that Go conference speakers and book/blog authors have gotten me more familiar with the lower-level underpinnings of the code I write."
      }
    , { icon = "/images/elm100.png"
      , title = "Elm"
      , detail = "Elm hit my radar when I heard Dan Abramov mention it as an inspiration for Redux. Elm pulls together the best features from other languages I love; functional purity, a really nice type system, and a declarative approach to building UIs."
      }
    ]


favoriteMusic : List Favorite
favoriteMusic =
    [ { icon = "/images/miles100.jpg"
      , title = "Miles Davis - My Funny Valentine + Four & More"
      , detail = "To me, this album is the gold standard for straight-ahead jazz. The band transitions effortlessly between lyrical introductions, intense yet controlled swing choruses, and fiery climaxes. Tony Williams's rare ability to sit out for long stretches of time make the performances feel orchestrated."
      }
    , { icon = "/images/ellington100.jpg"
      , title = "Duke Ellington - Such Sweet Thunder"
      , detail = "Duke Ellington and Billy Strayhorn were exceptionally gifted at writing music for the specific voices of their band members, and this twelve movement suite showcases the orchestra at its very best. The music overflows with personality and joy."
      }
    , { icon = "/images/coltrane100.jpg"
      , title = "John Coltrane - Coltrane's Sound"
      , detail = "John Coltrane's tone on the tenor is one of the most beautiful instrumental sounds I've ever heard. There's a high degree of sincerity and humanity behind every note. I picked this album somewhat arbitrarily, as Live at the Vanguard, A Love Supreme, and so many others are also perfect. Trane's all-consuming dedication to his craft is an inspiration that I draw from frequently."
      }
    , { icon = "/images/bach100.jpg"
      , title = "Glenn Gould - Bach: The Goldberg Variations"
      , detail = "JS Bach's mastery of counterpoint is unparalleled. The Goldberg Variations are among my favorite of his works, and both Glenn Gould recordings (1955 and 1981) are spectacular."
      }
    , { icon = "/images/messiaen100.jpg"
      , title = "Olivier Messiaen - Turangalîla-Symphonie"
      , detail = "Messiaen's Turangalila, written in the late 1940s, sounds as modern as almost anything composed today. Few other composers have been able to find their own voice along all of music's axes - melody, harmony, rhythm, orchestration, and form. I've spent a great deal of time studying Messiaen's techniques and trying to emulate them in my own work."
      }
    ]


renderFavorite : Favorite -> Html msg
renderFavorite favorite =
    div
        [ class "favorite" ]
        [ div [ class "favorite__title" ] [ text favorite.title ]
        , div [ class "favorite__info" ]
            [ div [ class "favorite__icon" ] [ img [ src favorite.icon, alt favorite.title ] [] ]
            , div [ class "favorite__detail" ] [ text favorite.detail ]
            ]
        ]


renderFavorites : List Favorite -> Html msg
renderFavorites list =
    div [ class "favorites" ]
        (List.map renderFavorite list)


tech : Html msg
tech =
    renderFavorites favoriteTech


music : Html msg
music =
    renderFavorites favoriteMusic

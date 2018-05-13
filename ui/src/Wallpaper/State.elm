module Wallpaper.State exposing (init)

import Wallpaper.Types exposing (..)


-- http://azer.bike/photo/37431826436


pointreyes : Image
pointreyes =
    Image "center"
        [ File 640 "https://c1.staticflickr.com/5/4493/37431826436_ceccd9f535_z.jpg"
        , File 800 "https://c1.staticflickr.com/5/4493/37431826436_ceccd9f535_c.jpg"
        , File 1024 "https://c1.staticflickr.com/5/4493/37431826436_ceccd9f535_b.jpg"
        , File 1600 "https://c1.staticflickr.com/5/4493/37431826436_fd71503889_h.jpg"
        , File 3000 "https://c1.staticflickr.com/5/4493/37431826436_8e42d288d4_k.jpg"
        , File 5212 "https://c1.staticflickr.com/5/4493/37431826436_cce0de098f_o.jpg"
        ]



-- http://azer.bike/photo/36821546343


sahara : Image
sahara =
    Image "center bottom"
        [ File 640 "https://c1.staticflickr.com/5/4505/36821546343_9d1f087a58_z.jpg"
        , File 800 "https://c1.staticflickr.com/5/4505/36821546343_9d1f087a58_c.jpg"
        , File 1024 "https://c1.staticflickr.com/5/4505/36821546343_9d1f087a58_b.jpg"
        , File 1600 "https://c1.staticflickr.com/5/4505/36821546343_5c7bd29631_h.jpg"
        , File 2048 "https://c1.staticflickr.com/5/4505/36821546343_3c14e47733_k.jpg"
        , File 5212 "https://c1.staticflickr.com/5/4505/36821546343_51e0e4d3db_o.jpg"
        ]


init : Model
init =
    Model sahara ""

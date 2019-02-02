module Bio exposing (..)

import Html exposing (..)
import Markdown


bio =
    Markdown.toHtml [] """
Welcome to my website! I’m a software engineer from Wisconsin, currently living in Massachusetts with my wife and son.

I work at America's Test Kitchen, where I help build and maintain a portfolio of food and recipe websites including americastestkitchen.com, cookscountry.com, cooksillustrated.com, and onlinecookingschool.com. Prior to that, I worked at Geisel Software; a consultancy specializing in Internet of Things & embedded development. I enjoy learning new programming languags and have written production code in quite a few of them (Go, Elixir, Ruby, JavaScript, Python, PHP).

Outside of programming, I'm passionate about jazz music. I hold a doctorate from the Manhattan School of Music, and used to work as a jazz trumpet player and composer. I don't play professionally any longer but I still hold a deep love for jazz music and listen to a lot of it while I code.

If you'd like to contact me, send an email to  aczerepinski at google's email service, or use any of the social media links on this page. Thanks for visiting!

Adam
"""


render : Html msg
render =
    bio

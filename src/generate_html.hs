{-# LANGUAGE OverloadedStrings #-}

import Data.Text (Text, pack)
import qualified Data.Text.IO as TIO
import qualified Data.Text as T
import System.IO

data Language = Language
  { name :: Text
  , description :: Text
  , githubLink :: Text
  }

languages :: [Language]
languages =
  [ Language "Ixion" 
      "Компилируемый Python, но со статик типизацией, монадами, и другими синтаксическими решениями" 
      "https://github.com/IxionLang/Ixion"
  , Language "Hazel" 
      "Функциональный язык программирования, написан на reasonMl" 
      "https://github.com/hazelgrove/hazel"
  , Language "Ka-Pi" 
      "Библиотека для работы с jvm байт-кодом на Rust" 
      "https://github.com/ChAoSUnItY/Ka-Pi"
  , Language "Stellar" 
      "Язык программирования для создания музыки, написанный на Rust" 
      "https://github.com/abs0luty/stellar"
  , Language "Stockfish-Java"
      "Обертка шахматного движка stockfish под java" 
      "https://github.com/senyast4745/Stockfish-Java"
  , Language "GRIN" 
      "Бекенд для компиляторов функциональных языков" 
      "https://github.com/grin-compiler/grin"
  ]

generateHTML :: [Language] -> Text
generateHTML langs = 
  "<!DOCTYPE html>\n" <>
  "<html>\n" <>
  "  <head>\n" <>
  "    <meta charset=\"utf-8\"/>\n" <>
  "    <title>Архив</title>\n" <>
  "    <meta name=\"description\" content=\"Архив\"/>\n" <>
  "    <meta name=\"keywords\" content=\"Архив\"/>\n" <>
  "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n" <>
  "    <style>\n" <>
  "    * {\n" <>
  "      font-family: monospace;\n" <>
  "      font-size: 24px;\n" <>
  "      padding: 0;\n" <>
  "      margin: 0;\n" <>
  "      border: 0;\n" <>
  "      box-sizing: border-box;\n" <>
  "    }\n" <>
  "    .center {\n" <>
  "      text-align: center;\n" <>
  "      width: 20em;\n" <>
  "      max-width: 100%;\n" <>
  "      padding: 1em;\n" <>
  "      height: 40em;\n" <>
  "      position: absolute;\n" <>
  "      top: 0;\n" <>
  "      bottom: 0;\n" <>
  "      left: 0;\n" <>
  "      right: 0;\n" <>
  "      margin: auto;\n" <>
  "    }\n" <>
  "    p {\n" <>
  "      margin: 1em 0;\n" <>
  "    }\n" <>
  "    </style>\n" <>
  "  </head>\n" <>
  "  <body>\n" <>
  "    <div class=\"center\">\n" <>
  T.concat (map generateLanguageHTML langs) <>  -- исправлено здесь
  "    </div>\n" <>
  "  </body>\n" <>
  "</html>"

generateLanguageHTML :: Language -> Text
generateLanguageHTML lang =
  "<p><strong>" <> name lang <> "</strong> - " <> description lang <> 
  " (<a href=\"" <> githubLink lang <> "\">Github</a>)</p>\n"


main :: IO ()
main = do
    let htmlContent = generateHTML languages
    withFile "archive.html" WriteMode $ \h -> do
        hSetEncoding h utf8
        TIO.hPutStr h htmlContent
  
-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Config-Gnome.html
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Multi_head_and_workspaces_.28desktops.29

import XMonad
import XMonad.Config.Gnome

main = xmonad gnomeConfig

-- import XMonad
-- import XMonad.Config.Gnome
-- import qualified XMonad.StackSet as W
-- import XMonad.Util.EZConfig
--
-- main = do
--     xmonad $ gnomeConfig {
--         workspaces = myWorkspaces
--         -- skipped
--         } `additionalKeysP` myKeys
--
-- myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
--
-- myKeys =
--     [ (otherModMasks ++ "M-" ++ [key], action tag)
--       | (tag, key)  <- zip myWorkspaces "123456789"
--       , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
--                                       , ("S-", windows . W.shift)]
--     ]

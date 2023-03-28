import System.IO
import System.Exit

import qualified Data.List as L

import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Actions.UpdatePointer

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.LayoutModifier
import XMonad.Layout.Gaps
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Fullscreen
import XMonad.Layout.BinarySpacePartition as BSP
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ZoomRow
import XMonad.Layout.IndependentScreens

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Cursor
import XMonad.Util.NamedScratchpad
import XMonad.Util.WorkspaceCompare (getSortByXineramaRule)

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.List -- for `isSuffixOf`
import Data.Ratio ((%))

import qualified XMonad.StackSet as SS
import Data.Monoid (All (All))
import Foreign.C (CInt)
import Control.Monad (when)
import Data.Foldable (find)

------------------------------------------------------------------------
-- Terminimport XMonad.Hooks.EwmhDesktopsal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "$HOME/.local/bin/alacritty"
myBrowser = "qutebrowser"

-- The command to lock the screen or show the screensaver.
myScreensaver = "slock"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "dmenu_run"


------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["A", "B", "C", "D", "E"]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [
    resource  =? "desktop_window"    --> doIgnore
    , className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "Gimp"            --> doFloat
    , (className =? "Gimp" <&&> fmap ("tool" `isSuffixOf`) role) --> doFloat
    , className =? "MPlayer"         --> doCenterFloat
    , className =? "Pavucontrol"     --> doCenterFloat
    , className =? "cpupower-gui"    --> doCenterFloat
    -- , className =? "VirtualBox Manager"  --> doFloat
    , className =? "Skype"               --> doShift "0_E"
    , className =? "zoom"                --> doShift "0_E"
    , className =? "Screenkey"           --> doFloat
    , isDialog                           --> doFloat
    , isFullscreen                       --> (doF W.focusDown <+> doFullFloat)
    --, isFullscreen                                --> doFullFloat
    ]
    <+> namedScratchpadManageHook myScratchPads
    where role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
-- Scratchpads
-- 
--
myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "calculator" spawnCalc findCalc manageCalc
                ]
  where
    spawnCalc  = "mate-calc"
    findCalc   = className =? "Calculator"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.3
                 w = 0.3
                 t = 0.35 -h
                 l = 0.70 -w


------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

outerGaps = 5 
tabGaps = gaps [(U, 8), (R, 8), (L, 8), (D, 8)]
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

tab          = renamed [Replace "tabs"]
               $ addTopBar
               $ tabGaps
               $ tabbed shrinkText myTabTheme

bsp          = renamed [CutWordsLeft 1]
               $ addTopBar
               $ windowNavigation
               $ renamed [Replace "bsp"]
               $ addTabs shrinkText myTabTheme
               $ subLayout [] Simplest
               $ mySpacing outerGaps (BSP.emptyBSP)

tall         = renamed [Replace "tall"]
               $ addTopBar
               $ windowNavigation
               $ addTabs shrinkText myTabTheme
               $ subLayout [] Simplest
               $ limitWindows 8
               $ mySpacing outerGaps
               $ ResizableTall 1 (3/100) (1/2) []

grid         = renamed [Replace "grid"]
               $ addTopBar
               $ windowNavigation
               $ addTabs shrinkText myTabTheme
               $ subLayout [] Simplest
               $ limitWindows 8
               $ mySpacing outerGaps
               $ mkToggle (single MIRROR)
               $ Grid (16/10)

floats       = renamed [Replace "floats"]
               $ limitWindows 20 simplestFloat

threecol     = renamed [Replace "threecol"]
               $ addTopBar
               $ windowNavigation
               $ addTabs shrinkText myTabTheme
               $ subLayout [] Simplest
               $ limitWindows 7
               $ mySpacing outerGaps
               $ ThreeCol 1 (3/100) (1/2)

layouts      = bsp ||| tab ||| tall ||| grid ||| threecol ||| floats

myLayout     = avoidStruts $ smartBorders
               $ mkToggle (NOBORDERS ?? FULL ?? EOT)
               $ layouts

myNav2DConf = def
    { defaultTiledNavigation    = centerNavigation
    , floatNavigation           = centerNavigation
    , screenNavigation          = lineNavigation
    , layoutNavigation          = [("Full",          centerNavigation)
    -- line/center same results   ,("Tabs", lineNavigation)
    --                            ,("Tabs", centerNavigation)
                                  ]
    , unmappedWindowRect        = [("Full", singleWindowRect)
    -- works but breaks tab deco  ,("Tabs", singleWindowRect)
    -- doesn't work but deco ok   ,("Tabs", fullScreenRect)
                                  ]
    }

------------------------------------------------------------------------
-- Colors and borders

-- Color of current window title in xmobar.
xmobarTitleColor = "#C678DD"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#51AFEF"

-- Width of the window border in pixels.
myBorderWidth = 2

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = active

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"
darkgreen = "#006600"

-- sizes
gap         = 5
topbar      = 10
border      = 0
prompt      = 20
status      = 20

active      = darkgreen
activeWarn  = red
inactive    = base02
focusColor  = blue
unfocusColor = base02

myFont      = "xft:NotoSansMono:size=9:bold:antialias=true"
myBigFont   = "xft:NotoSansMono:size=9:bold:antialias=true"
myWideFont  = "xft:NotoSansMono:style=Regular:pixelsize=180:hinting=true"

-- this is a "fake title" used as a highlight bar in lieu of full borders
-- (I find this a cleaner and less visually intrusive solution)
topBarTheme = def
    {
      fontName              = myFont
    , inactiveBorderColor   = base03
    , inactiveColor         = base03
    , inactiveTextColor     = base03
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = active
    , urgentBorderColor     = red
    , urgentTextColor       = yellow
    , decoHeight            = topbar
    }

addTopBar =  noFrillsDeco shrinkText topBarTheme

myTabTheme = def
    { fontName              = myFont
    , activeColor           = active
    , inactiveColor         = base02
    , activeBorderColor     = active
    , inactiveBorderColor   = base02
    , activeTextColor       = base03
    , inactiveTextColor     = base00
    }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask

dmenuKeys :: [(String, X ())]
dmenuKeys =
  [ 
       ("M-p",    spawn myLauncher )
      ,("M-o",    spawn "$HOME/.local/bin/dmscripts/dm-hub")
  ]

myDmenuKeys = \c -> mkKeymap c dmenuKeys

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- Spawn Qutebrowser browser
  , ((modMask .|. shiftMask, xK_backslash),
     spawn myBrowser)

  -- Lock the screen using command specified by myScreensaver.
  , ((modMask, xK_0),
     spawn myScreensaver)

  , ((modMask .|. shiftMask, xK_p),
     spawn "$HOME/.config/rofi/menu.sh")

  , ((modMask .|. shiftMask, xK_a),
     spawn "/usr/bin/rofi -show drun")

  -- Toggle current focus window to fullscreen
  , ((modMask, xK_f), sendMessage $ Toggle FULL)

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Display Gridselect
  , ((modMask .|. shiftMask, xK_l),
     spawnSelected' myAppGrid)

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_k),
     windows W.focusUp)

  -- Move focus to the previous window.
  , ((modMask, xK_j),
     windows W.focusDown  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)

  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((modMask .|. e, k), windows $ onCurrentScreen f i)
      | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_5]
      , (f, e) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2 or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2 or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  ++

  -- Bindings for manage sub tabs in layouts please checkout the link below for reference
  -- https://hackage.haskell.org/package/xmonad-contrib-0.13/docs/XMonad-Layout-SubLayouts.html
  [
    -- Tab current focused window with the window to the left
    ((modMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
    -- Tab current focused window with the window to the right
  , ((modMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
    -- Tab current focused window with the window above
  , ((modMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
    -- Tab current focused window with the window below
  , ((modMask .|. controlMask, xK_j), sendMessage $ pullGroup D)

  -- Tab all windows in the current workspace with current window as the focus
  , ((modMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
  -- Group the current tabbed windows
  , ((modMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))

  -- Toggle through tabes from the right
  , ((modMask, xK_Tab), onGroup W.focusDown')
  ]

  ++
  -- Some bindings for BinarySpacePartition
  -- https://github.com/benweitzman/BinarySpacePartition
  [
    ((modMask .|. controlMask,               xK_Right ), sendMessage $ ExpandTowards R)
  , ((modMask .|. controlMask .|. shiftMask, xK_Right ), sendMessage $ ShrinkFrom R)
  , ((modMask .|. controlMask,               xK_Left  ), sendMessage $ ExpandTowards L)
  , ((modMask .|. controlMask .|. shiftMask, xK_Left  ), sendMessage $ ShrinkFrom L)
  , ((modMask .|. controlMask,               xK_Down  ), sendMessage $ ExpandTowards D)
  , ((modMask .|. controlMask .|. shiftMask, xK_Down  ), sendMessage $ ShrinkFrom D)
  , ((modMask .|. controlMask,               xK_Up    ), sendMessage $ ExpandTowards U)
  , ((modMask .|. controlMask .|. shiftMask, xK_Up    ), sendMessage $ ShrinkFrom U)
  , ((modMask,                               xK_r     ), sendMessage BSP.Rotate)
  ]

------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]

------------------------------------------------------------------------
-- GridSelect menu layout
--
--
spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 200
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

myAppGrid = [
                   ("Terminal",     "alacritty")
                 , ("Qutebrowser",  "qutebrowser")
                 , ("PCManFM",      "pcmanfm")
                 , ("Skype",        "skypeforlinux")
                 , ("Zoom",         "zoom")
                 , ("Calc",         "mate-calc")
                 ]

-- focus empty workspace on cursor hover

multiScreenFocusHook :: Event -> X All
multiScreenFocusHook MotionEvent { ev_x = x, ev_y = y } = do
  ms <- getScreenForPos x y
  case ms of
    Just cursorScreen -> do
      let cursorScreenID = SS.screen cursorScreen
      focussedScreenID <- gets (SS.screen . SS.current . windowset)
      when (cursorScreenID /= focussedScreenID) (focusWS $ SS.tag $ SS.workspace cursorScreen)
      return (All True)
    _ -> return (All True)
  where getScreenForPos :: CInt -> CInt
            -> X (Maybe (SS.Screen WorkspaceId (Layout Window) Window ScreenId ScreenDetail))
        getScreenForPos x y = do
          ws <- windowset <$> get
          let screens = SS.current ws : SS.visible ws
              inRects = map (inRect x y . screenRect . SS.screenDetail) screens
          return $ fst <$> find snd (zip screens inRects)
        inRect :: CInt -> CInt -> Rectangle -> Bool
        inRect x y rect = let l = fromIntegral (rect_x rect)
                              r = l + fromIntegral (rect_width rect)
                              t = fromIntegral (rect_y rect)
                              b = t + fromIntegral (rect_height rect)
                           in x >= l && x < r && y >= t && y < b
        focusWS :: WorkspaceId -> X ()
        focusWS id = io (putStrLn $ "Focussing " ++ show id) >> windows (SS.view id)
multiScreenFocusHook _ = return (All True)

------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  ewmhDesktopsStartup 
  spawn     "bash ~/.xmonad/startup.sh"
  setDefaultCursor xC_left_ptr
--  setWMName "LG3D"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  n <- countScreens
  nScreens <- countScreens
  xmprocs <- mapM (\i -> spawnPipe $ "xmobar ~/.xmonad/xmobar-" ++ show i ++ ".hs" ++ " -x " ++ show i) [0..n-1]
  xmonad $ ewmh $ docks
         $ withNavigation2DConfig myNav2DConf
         $ additionalNav2DKeys (xK_Up, xK_Left, xK_Down, xK_Right)
                               [
                                  (mod4Mask,               windowGo  )
                                , (mod4Mask .|. shiftMask, windowSwap)
                               ]
                               False
         $ defaults {
         logHook = mapM_ (\handle -> dynamicLogWithPP xmobarPP { 
            ppOutput = System.IO.hPutStrLn handle
            , ppSort    = getSortByXineramaRule
            , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "[" "]"
            , ppTitle = xmobarColor xmobarTitleColor "" . shorten 50
            , ppExtras = [windowCount]
            , ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
         }) xmprocs
         >> updatePointer (0.75, 0.75) (0.75, 0.75),
         workspaces         = withScreens nScreens myWorkspaces
      }
------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys <+> myDmenuKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    rootMask           = rootMask def .|. pointerMotionMask,
    layoutHook         = showWName' myShowWNameTheme $ myLayout,
    handleEventHook    = XMonad.Hooks.EwmhDesktops.fullscreenEventHook <+> multiScreenFocusHook,
    manageHook         = manageDocks <+> myManageHook,
    startupHook        = myStartupHook
}

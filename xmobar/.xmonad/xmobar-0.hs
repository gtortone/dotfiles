Config {
       font = "xft:JetBrainsMonoNerdFontMono:size=12:bold:antialias=true"
       , additionalFonts = [ "xft:FontAwesome:size=12:normal:antialias=true" ]
       , allDesktops = False
       , bgColor = "#282c34"
       , fgColor = "#bbc2cf"
       , position = TopSize L 93 24
       , commands = [ 
                    Run MultiCpu [ "-t", "<fc=#a9a1e1><fn=1></fn></fc> <total>%"
                              , "--Low","10"
                              , "--High","60" 
                              , "--low","#98be65"
                              , "--normal","#ebeb10"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","<fc=#51afef><fn=1></fn></fc> <usedratio>%"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#bbc2cf"
                                 ,"-n","#bbc2cf"
                                 ,"-h","#fb4934"
                                 ,"-p","2" ] 50

                    , Run Date "<fc=#ECBE7B><fn=1></fn></fc> %a %b %_d %H:%M" "date" 300
                    , Run DynNetwork ["-t","<rx> <fc=#4db5bd><fn=1></fn></fc> <fc=#c678dd><fn=1></fn></fc> <tx>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#bbc2cf"
                                     ,"-l","#bbc2cf"
                                     ,"-n","#bbc2cf"
                                     ,"-S","True"
                                     ,"-w", "7" ] 50

                    , Run CoreTemp ["-t", "<fc=#CDB464><fn=1></fn></fc> <core0>°"
                                   , "-L", "30"
                                   , "-H", "75"
                                   , "-l", "lightblue"
                                   , "-n", "#bbc2cf"
                                   , "-h", "#aa4450" ] 50

                    -- battery monitor
                    , Run BatteryP       [ "BAT0" ]
                                         [ "--template" , "<fc=#B1DE76><fn=1></fn></fc> <acstatus>"
                                         , "--Low"      , "10"        -- units: %
                                         , "--High"     , "80"        -- units: %
                                         , "--low"      , "#fb4934" -- #ff5555
                                         , "--normal"   , "#bbc2cf"
                                         , "--high"     , "#98be65"
                                         , "-p"         , "2"
                                         , "--" -- battery specific options
                                         -- discharging status
                                         , "-o"   , "<left>% (<timeleft>)"
                                         -- AC "on" status
                                         , "-O"   , "<left>% (<fc=#98be65>Charging</fc>)" -- 50fa7b
                                         -- charged status
                                         , "-i"   , "<fc=#98be65>Charged</fc> <left>%" 
                                         , "-a"   , "notify-send -h string:x-canonical-private-synchronous:low_battery -t 10000 -u critical 'Low Battery'" ] 100
                    , Run Com "cat" ["/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"] "governor" 600
                    , Run StdinReader
                    , Run PipeReader "/var/run/user/1000/volume-display" "volume"
                    , Run PipeReader "/var/run/user/1000/caps-display" "caps"
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %multicpu% | %coretemp% | %memory% | %battery% | %dynnetwork% | <action=`gsimplecal`>%date%</action> | <action=`pavucontrol`>%volume%</action> | <action=`cpupower-gui`>%governor%</action> | %caps%   "   -- #69DFFA
}

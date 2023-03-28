Config {
       font = "JetBrainsMonoNerdFontMono semibold 12"
       , additionalFonts = [ "FontAwesome 12" ]
       , allDesktops = False
       , bgColor = "#282c34"
       , fgColor = "#bbc2cf"
       , position = TopSize L 100 26
       , commands = [ 
                       Run StdinReader
                     , Run Date "<fc=#ECBE7B><fn=1></fn></fc> %a %b %_d %H:%M" "date" 300
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ <action=`gsimplecal`>%date%</action> |"   -- #69DFFA
}

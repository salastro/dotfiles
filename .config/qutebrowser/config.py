config.load_autoconfig(True)

c.aliases = {'h': 'help', 're': 'restart', 'q': 'quit', 'qp': 'spawn --userscript qute-pass -d dmenu', 'qpo': 'spawn --userscript qute-pass -d dmenu --otp-only'}

c.colors.webpage.preferred_color_scheme = "dark"
config.set("content.javascript.can_access_clipboard", True ,"https://*.github.com/*")
c.spellcheck.languages = ["en-US"]
c.auto_save.session = True
c.content.autoplay = False
c.content.webgl = False
c.content.notifications.enabled = False
c.content.tls.certificate_errors = "block"
c.completion.web_history.max_items = 0
c.downloads.location.directory = '~/Downloads'
c.input.insert_mode.auto_load = True

c.tabs.show = 'always'
c.statusbar.show = 'always'

c.url.default_page = 'file:///home/salahdin/.srcpkgs/gruvbox-cat/index.html'
c.url.start_pages = 'file:///home/salahdin/.srcpkgs/gruvbox-cat/index.html'

c.url.searchengines = {'DEFAULT': 'https://paulgo.io/search?q={}', \
        'aw': 'https://wiki.archlinux.org/?search={}', \
        'g': 'https://www.google.com/search?q={}', \
        'ub': 'https://www.urbandictionary.com/define.php?term={}', \
        'w': 'https://en.wikipedia.org/wiki/{}', \
        'gh': 'https://www.github.com/search?q={}', \
        'ddg': 'https://duckduckgo.com/?q={}', \
        'mdn': 'https://developer.mozilla.org/en-US/search?q={}'}

# Ad blocking
c.content.blocking.adblock.lists = [ \
        "https://easylist.to/easylist/easylist.txt", \
        "https://easylist.to/easylist/easyprivacy.txt", \
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt", \
        "https://easylist.to/easylist/fanboy-annoyance.txt", \
        "https://secure.fanboy.co.nz/fanboy-annoyance.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt", \
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt" \
        ]

c.content.blocking.enabled = True
c.content.blocking.method = 'both'

# Open cmd-line editor instead
import os
c.editor.command = [
    os.environ["TERMINAL"],
    "-e",
    os.environ["EDITOR"],
    "-f",
    "{file}",
    "-c",
    "normal {line}G{column0}1",
]

# Bindings for normal mode
config.bind('<Ctrl-m>', 'hint links spawn mpv --force-window --keep-open=yes --ytdl {hint-url}')
config.bind('z', 'hint links spawn st -e youtube-dl {hint-url} -o "~/Videos/%(title)s-%(id)s.%(ext)s"')
config.bind('<Ctrl-Shift-m>', 'spawn --userscript view_in_mpv')
config.bind('Z', 'spawn st -e youtube-dl {url} -o "~/Videos/%(title)s-%(id)s.%(ext)s"')

config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')

config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('gJ', 'tab-move -')
config.bind('gK', 'tab-move +')
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('D', 'tab-close')
config.bind('U', 'undo')
# config.bind(';', 'mode-enter command')

config.bind('I', 'mode-enter passthrough')
config.bind('<Ctrl-q>', 'spawn --userscript qr')
config.bind('<Ctrl-r>', 'spawn --userscript readability')
config.bind("yo", "yank inline [{title}]({url})")
config.bind('tt', 'set-cmd-text -s :open -t')

config.bind('cu', 'config-source')

config.unbind('<Ctrl-a>')
config.unbind('<Ctrl-v>')

# config.bin("<Ctrl-a>", "spawn --userscript qute-pass -d /user/bin/dmenu")
# config.bin("<Alt-Shift-d>", "spawn --userscript qute-pass -d dmenu --otp-only")

# QuteWal, a pywal plugin for qutebrowser
# config.source('qutewal.py')
# c.colors.webpage.darkmode.algorithm = 'brightness-rgb'
# c.colors.webpage.darkmode.enabled = True
# c.colors.webpage.darkmode.grayscale.all = True
config.bind(
    "ac", "config-cycle content.user_stylesheets ~/.config/qutebrowser/css/fix.css ''")
config.bind(
    "ag", "config-cycle content.user_stylesheets ~/.config/qutebrowser/css/gruvbox.css ''")
# c.colors.webpage.prefers_color_scheme_dark = True
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-hsl'
c.colors.webpage.darkmode.contrast = -.022
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.darkmode.threshold.background = 100
c.colors.webpage.darkmode.policy.images = 'always'
c.colors.webpage.darkmode.grayscale.images = 0.35

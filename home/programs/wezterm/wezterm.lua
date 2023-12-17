local wezterm = require("wezterm")

return {
    keys = {
        -- Disable annoying MacOS window shortcuts
        {
            key = "h",
            mods = "SHIFT|CTRL",
            action = wezterm.action.DisableDefaultAssignment
        },
        {
            key = "l",
            mods = "SHIFT|CTRL",
            action = wezterm.action.DisableDefaultAssignment
        },
    },
    enable_wayland = false;
    color_scheme = "tokyonight_moon",
    window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW",
    window_background_opacity = 0.85,
    enable_tab_bar = false,
    font = wezterm.font({
        family = "GeistMono Nerd Font",
        weight = "DemiBold",
    }),
    font_size = 11,
    font_rules = {
        {
            intensity = "Half",
			font = wezterm.font({
				family = "GeistMono Nerd Font",
				weight = "Bold",
            }),
        },
        {
            intensity = "Bold",
			font = wezterm.font({
				family = "GeistMono Nerd Font",
				weight = "Black",
            }),
        },
        {
            intensity = "Normal",
            italic = true,
			font = wezterm.font(
				"CaskaydiaCove Nerd Font",
				{ weight = "DemiLight", style = "Italic" }
			),
        },
        {
            intensity = "Half",
            italic = true,
			font = wezterm.font(
				"CaskaydiaCove Nerd Font",
				{ weight = "Medium", style = "Italic" }
			),
        },
        {
            intensity = "Bold",
            italic = true,
			font = wezterm.font(
				"CaskaydiaCove Nerd Font",
				{ weight = "DemiBold", style = "Italic" }
			),
        },
    },
    term = "wezterm",
}

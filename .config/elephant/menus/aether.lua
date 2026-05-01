-- aether.lua - Place in ~/.config/elephant/menus/
Name = "aether"
NamePretty = "Wallpapers & Themes"
Icon = "preferences-desktop-wallpaper"
SearchName = true
Searchable = true
Cache = false

-- Helper: safely quote a path for shell use
local function shell_quote(path)
  -- Wrap in single quotes, escape any single quotes inside the path
  return "'" .. path:gsub("'", "'\\''") .. "'"
end

function GetEntries()
  local entries = {}

  -- ── Top-level Aether options ──────────────────────────────────────────────

  table.insert(entries, {
    Text    = "Open Aether App",
    Subtext = "Full theme creator interface",
    Icon    = "preferences-desktop-theme",
    Exec    = "aether",
  })

  table.insert(entries, {
    Text    = "Browse Wallhaven",
    Subtext = "Search and download online wallpapers",
    Icon    = "network-workgroup",
    Exec    = "aether -w",
  })

  table.insert(entries, {
    Text    = "List Saved Blueprints",
    Subtext = "View all saved theme blueprints",
    Icon    = "view-list-symbolic",
    Exec    = "aether -l",
  })

  -- ── Wallpapers ────────────────────────────────────────────────────────────

  local wallpaper_dir = "/home/rafael/Wallpapers"
  local handle = io.popen(
    "find " .. shell_quote(wallpaper_dir) ..
    " -maxdepth 1 -type f" ..
    " \\( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \\)" ..
    " 2>/dev/null | sort"
  )

  if handle then
    for wallpaper_path in handle:lines() do
      local filename = wallpaper_path:match("([^/]+)$")
      if filename then
        local q = shell_quote(wallpaper_path)

        -- Default Enter: animated wallpaper switch + auto theme generation
        local default_exec = string.format(
          "sh -c 'swww img %s --transition-type wave --transition-angle 45 && aether -g %s'",
          q, q
        )

        table.insert(entries, {
          Text        = filename,
          Subtext     = "Enter: apply with animation + auto theme",
          Icon        = wallpaper_path,
          Preview     = wallpaper_path,
          PreviewType = "file",
          Value       = wallpaper_path,
          Exec        = default_exec,

          Actions     = {
            -- Just set wallpaper with animation, no theme change
            ["set_wallpaper"] = string.format(
              "swww img %s --transition-type wave --transition-angle 45", q),

            -- Light theme
            ["light_theme"] = string.format(
              "sh -c 'swww img %s --transition-type wipe --transition-angle 45 & aether -g %s --light-mode'",
              q, q),

            -- Monochromatic theme
            ["mono"] = string.format(
              "sh -c 'swww img %s --transition-type grow & aether -g %s --extract-mode=monochromatic'",
              q, q),

            -- Material theme
            ["material"] = string.format(
              "sh -c 'swww img %s --transition-type outer & aether -g %s --extract-mode=material'",
              q, q),

            -- Pastel theme
            ["pastel"] = string.format(
              "sh -c 'swww img %s --transition-type random & aether -g %s --extract-mode=pastel'",
              q, q),
          }
        })
      end
    end
    handle:close()
  end

  return entries
end

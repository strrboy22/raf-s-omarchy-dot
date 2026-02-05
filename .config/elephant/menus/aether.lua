-- aether.lua - Place in ~/.config/elephant/menus/

-- Metadata for Elephant
Name = "aether"
NamePretty = "Wallpapers & Themes"
Icon = "preferences-desktop-wallpaper"
SearchName = true
Searchable = true

-- Set a default action for wallpapers
Action = "aether -g %VALUE%"

-- Main menu
function GetEntries()
  local entries = {}

  -- Main Aether options
  table.insert(entries, {
    Text = "Open Aether App",
    Subtext = "Full theme creator interface",
    Icon = "preferences-desktop-theme",
    Value = "",
    -- Use Exec for the default Enter action
    Exec = "aether",
    Actions = {
      ["open"] = "aether"
    }
  })

  table.insert(entries, {
    Text = "Browse Wallhaven",
    Subtext = "Search and download online wallpapers",
    Icon = "network-workgroup",
    Exec = "aether -w",
    Actions = {
      ["browse"] = "aether -w"
    }
  })

  table.insert(entries, {
    Text = "List Saved Blueprints",
    Subtext = "View all saved theme blueprints",
    Icon = "view-list-symbolic",
    Exec = "aether -l",
    Actions = {
      ["list"] = "aether -l"
    }
  })

  -- Now add all wallpapers directly
  local wallpaper_dir = "/home/rafael/Wallpapers"
  local handle = io.popen("find '" .. wallpaper_dir ..
    "' -maxdepth 1 -type f \\( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \\) 2>/dev/null | sort")

  if handle then
    for wallpaper_path in handle:lines() do
      local filename = wallpaper_path:match("([^/]+)$")
      if filename then
        table.insert(entries, {
          Text = filename,
          Subtext = "Press Enter to generate and apply theme",
          Icon = wallpaper_path,
          Preview = wallpaper_path,
          PreviewType = "file",
          Value = wallpaper_path,
          -- Default action when pressing Enter
          Exec = string.format("aether -g '%s'", wallpaper_path),
          Actions = {
            ["generate"] = string.format("aether -g '%s'", wallpaper_path),
            ["set_wallpaper"] = string.format("aether -w '%s'", wallpaper_path),
            ["light_theme"] = string.format("aether -g '%s' --light-mode", wallpaper_path),
            ["mono"] = string.format("aether -g '%s' --extract-mode=monochromatic", wallpaper_path),
            ["material"] = string.format("aether -g '%s' --extract-mode=material", wallpaper_path),
            ["pastel"] = string.format("aether -g '%s' --extract-mode=pastel", wallpaper_path)
          }
        })
      end
    end
    handle:close()
  end

  return entries
end

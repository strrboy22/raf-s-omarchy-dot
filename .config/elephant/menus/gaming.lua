-- Steam Games Menu for Walker/Elephant
Name = "gaming"
NamePretty = "Steam Games"
Icon = "applications-games"
Searchable = true
SearchName = false
HideFromProviderlist = false

function GetEntries()
  local entries = {}

  -- Path to your Steam library folders config
  local vdf_path = os.getenv("HOME") .. "/.local/share/Steam/steamapps/libraryfolders.vdf"

  local f = io.open(vdf_path, "r")
  if not f then
    table.insert(entries, {
      Text = "Steam library not found",
      Subtext = vdf_path,
      Icon = "dialog-error"
    })
    return entries
  end

  local content = f:read("*all")
  f:close()

  local found_games = 0

  -- Find all paths in the vdf file
  for path in content:gmatch('"path"%s+"(.-)"') do
    local manifest_dir = path .. "/steamapps/"

    -- Escape the path properly for shell
    local escaped_path = manifest_dir:gsub("'", "'\\''")
    local handle = io.popen("find '" .. escaped_path .. "' -maxdepth 1 -name 'appmanifest_*.acf' 2>/dev/null")

    if handle then
      for manifest in handle:lines() do
        local mf = io.open(manifest, "r")
        if mf then
          local m_content = mf:read("*all")
          mf:close()

          local name = m_content:match('"name"%s+"(.-)"')
          local id = m_content:match('"appid"%s+"(.-)"')

          -- Filter out Steam tools/runtimes
          if name and id and not name:find("Steam Linux Runtime") and not name:find("Proton") and not name:find("Steamworks Common") then
            found_games = found_games + 1
            table.insert(entries, {
              Text = name,
              Subtext = "Steam Game",
              Icon = "steam_icon_" .. id,
              Actions = {
                launch = "steam steam://rungameid/" .. id
              }
            })
          end
        end
      end
      handle:close()
    end
  end

  -- Sort entries alphabetically by game name
  table.sort(entries, function(a, b)
    return a.Text:lower() < b.Text:lower()
  end)

  return entries
end

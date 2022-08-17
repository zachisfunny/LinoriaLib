--Settings | copy and paste [ UI Settings = Window:AddTab('UI Settings'), ] In your tabs for a UI Settings tab
Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

local MenuGroup = Tabs.UI Settings:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = false, Text = 'Menu keybind' }) 
MenuGroup:AddToggle('kbframevisible', {
    Text = 'Show Keybinds',
    Default = true,
    Tooltip = 'Shows your Keybinds',
})

Toggles.kbframevisible:OnChanged(function()
Library.KeybindFrame.Visible = Toggles.kbframevisible.Value
end)

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

ThemeManager:SetFolder('foldername')
SaveManager:SetFolder('foldername')

SaveManager:BuildConfigSection(Tabs.UI Settings) 

ThemeManager:ApplyToTab(Tabs.UI Settings)

local E = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AscensionUI") then return end

local function HandleCollections()
    local C = AscensionUI.Collections
    local K = AscensionUI.MythicKeystone.KeystoneInfo
    C:StripTextures(true)

    local itr = {
        C,
        CA2,
        K,
    }

    for i = 1, #C.Tab_Info do
        for _, frame in ipairs(itr) do
            local tab = frame["CollectionTab"..i]
            --tab:GetDisabledTexture():SetTexture()
            --tab.BG:SetTexture()
            S:HandleTab(tab)

            if i == 1 then
            --tab:ClearAllPoints()
            --tab:Point("TOPLEFT", frame, "BOTTOMLEFT", 20, 1)
            end
        end
    end
end

-- Vanity
local function HandleVanity()
    local V = AscensionUI.Store
    V:StripTextures(true)
    V:CreateBackdrop("Transparent")
    V.TitleText:FontTemplate(nil,12)

    -- Model Preview Frame
    V.ModelPreview.BGTex:Hide()
    V.ModelPreview_fake:CreateBackdrop("Default")

    -- Close Buttons
    S:HandleCloseButton(V.ModelPreview_fake.CloseButton)
    S:HandleCloseButton(V.CloseButton)

    -- Search Box
    S:HandleEditBox(V.SearchBox)

    -- Dropdown
    --S:HandleDropDownBox(V.StoreTypeList, 180)
    --UIDropDownMenu_JustifyText(V.StoreTypeList, "LEFT")

    -- Deliver Button
    S:HandleButton(V.ActivateStoreButton)

    -- Buy Button
    S:HandleButton(V.BuyStoreButton)
    V.BuyStoreButton:SetPoint("BOTTOMLEFT", 32,37)

    -- Previous Button
    S:HandleNextPrevButton(V.CollectionList.PrevButton, "left")

    -- Next Button
    S:HandleNextPrevButton(V.CollectionList.NextButton, "right")

    for i = 1, 9 do
        local name = "StoreCollectionItemFrame"..i
        local button = _G[name..".Button"]
        button:CreateBackdrop("Transparent")
        button.backdrop:SetBackdropBorderColor(0.90, 0.80, 0.50)
        _G[name..".BackgroundTexture"]:Hide()
        _G[name..".PrestigeTexture"]:Hide()
    end

    -- Banner Item
    V.Banner.HighlightTex:Hide()
    V.Banner.Glow:Hide()
    S:HandleIcon(V.Banner.Icon)
    V.Banner.Icon:GetParent():SetBackdropBorderColor(0.90, 0.80, 0.50)
    V.Banner.TitleText:SetFont("Fonts\\FRIZQT__.ttf", 12)
    V.Banner.DescText:SetSize(225, 0)

    -- Left Preview Thing
    V.Paper.TitleText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")

    -- Collection Header
    V.CollectionList.TitleText:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
end

-- Enchants
local function HandleMysticEnchants()
    local M = AscensionUI.MysticEnchant

    -- Main UI
    M:StripTextures(true)
    M:CreateBackdrop("Transparent")
    M.TitleText:FontTemplate(nil,12)

    -- Control Frame
    S:HandleButton(M.ControlFrame.RollButton)
    S:HandleButton(M.ControlFrame.ExtractButton)
    S:HandleButton(M.ManagerButton)
    M.ControlFrame.MoneyFrame:ClearAllPoints()
    M.ControlFrame.MoneyFrame:SetPoint("CENTER", M.ControlFrame, "CENTER", 0,0)
    M.ControlFrame.TokenFrame:ClearAllPoints()
    M.ControlFrame.TokenFrame:SetPoint("CENTER", M.ControlFrame, "CENTER", 0,0)
    M.ControlFrame.TokenFrame.TokenButton:ClearAllPoints()
    M.ControlFrame.TokenFrame.TokenButton:SetPoint("CENTER")
    M.ControlFrame.RollButton:ClearAllPoints()
    M.ControlFrame.RollButton:SetPoint("LEFT", M.ControlFrame, "LEFT", 0, 0)

    --Close button
    S:HandleCloseButton(M.CloseButton)

    -- Paper Doll Slots
    for i = 1, 19 do
        local slot = M.PaperDoll["Slot"..i]
        S:HandleItemButton(slot)
        slot.BG:SetTexture()
        slot.Icon:SetTexCoord(unpack(E.TexCoords))
        slot.Icon:SetParent(slot.backdrop)
    end

    -- Enchant Frame
    M.EnchantFrame:StripTextures(true)
    M.EnchantFrame.BG:Hide()
    M.EnchantFrame:CreateBackdrop("Transparent")
    M.EnchantFrame.Icon:SetTexture("Interface\\Icons\\spell_frost_stun")
    M.EnchantFrame.Icon:SetVertexColor(0.5, 0, 0.5, 0.5)
    M.EnchantFrame.Icon:SetTexCoord(unpack(E.TexCoords))

    -- Rotate Buttons
    S:HandleRotateButton(M.PaperDoll.ModelRotateLeftButton)
    S:HandleRotateButton(M.PaperDoll.ModelRotateRightButton)

    -- Search
    S:HandleEditBox(M.SearchBox)
    M.SearchBox:SetPoint("TOPRIGHT", M, -150, -33)

    -- Progress Bar
    S:HandleStatusBar(M.ProgressBar, {0, 0.6, 0, 1})
    
    -- Dropdown
    S:HandleDropDownBox(M.EnchantTypeList)
    UIDropDownMenu_JustifyText(M.EnchantTypeList, "LEFT")

    -- Previous Button
    S:HandleNextPrevButton(M.CollectionsList.PrevButton, "left")

    -- Next Button
    S:HandleNextPrevButton(M.CollectionsList.NextButton, "right")

    -- Collection Enchants
    for i = 1, 15 do
        local frame = _G["CollectionItemFrame"..i]
        frame:CreateBackdrop("Transparent")
        frame:SetSize(145, 40)
        frame.BackgroundTexture:SetSize(40, 40)
        frame.IconHighlight:Hide()
        frame.BG:Hide()
        frame.IconBorder:Hide()
        frame.BackgroundTexture:SetTexCoord(unpack(E.TexCoords))

        hooksecurefunc(frame, "Show", function()
            frame.backdrop:SetBackdropBorderColor(unpack(frame.Button.textColor))
            local spellId = frame.Button.Spell:match("spell:(%d+)|h")
            local _, _, icon = GetSpellInfo(spellId)
            frame.BackgroundTexture:SetTexture(icon)
        end)
    end

    -- Enchant Presets
    M.Manager:StripTextures(true)
    M.Manager:CreateBackdrop("Transparent")
    --S:HandleCloseButton(MysticEnchantingFrame.ManagerClose)
    --S:HandleScrollBar(M.Manager.scroll.ScrollBar)
    M.Manager.PreviewPaperDoll:StripTextures(true)
    M.Manager.PreviewPaperDoll:CreateBackdrop("Transparent")
    --S:HandleCloseButton(MysticEnchantingFrame.PreviewPaperDollClose)
    S:HandleButton(M.Manager.PreviewPaperDoll.LoadButton)
    S:HandleButton(M.Manager.PreviewPaperDoll.SaveButton)
    S:HandleButton(M.ManagerButton)

    for i = 1, 100 do
        local btn = _G["MysticEnchantingFrame.Manager.contentFrame.button"..i]
        --btn.Border:CreateBackdrop("Default")
        --btn.Border:StripTextures(true)
        btn.Border:SetSize(256,48)
        --specs:SetSize(225,48)
        
        btn.Text:FontTemplate(nil,12)
        btn.Text_Add:FontTemplate(nil,12)

    end

    -- Enchant Limits
    M.EnchantLimits.Legendary:StripTextures(true)
    M.EnchantLimits.Epic:StripTextures(true)

    -- Mystic Orb (currency) Frames
    M.CollectionsList.CurrencyOrbs.OrbText:FontTemplate(nil,12)
    M.CollectionsList.CurrencyOrbs:StripTextures(true)
    M.CollectionsList.CurrencyOrbs:CreateBackdrop("Transparent")
    M.ControlFrame.Currency:StripTextures(true)
    M.ControlFrame.Currency:CreateBackdrop("Transparent")

    -- Level Frame
    M.LevelFrame:Hide()
end

-- Sesonal
local function HandleSeasonCollection()
    local Collection = AscensionUI.SeasonalCollection

    Collection:StripTextures(true)
    Collection:CreateBackdrop("Transparent")
    Collection.TitleText:FontTemplate(nil,12)

    -- Spend Points Button
    S:HandleButton(Collection.SpendPoints.MainButton)
    Collection.SpendPoints.BG:Hide()

    -- Move Glow over
    Collection.ModelBG.BigGlow:SetPoint("LEFT", 0, 120)

    -- Previous Button
    S:HandleNextPrevButton(Collection.CosmeticReward.PrevButton, "left")

    -- Next Button
    S:HandleNextPrevButton(Collection.CosmeticReward.NextButton, "right")

    -- Scroll Bar
    S:HandleScrollBar(Collection.SmallChallengesFrame.Scroll_Features.ScrollBar)

    -- Small Challenges
    Collection.SmallChallengesFrame.BG:Hide()
    Collection.SmallChallengesFrame.GoldBG:Hide()
    Collection.SmallChallengesFrame.LineUp:Hide()
    Collection.SmallChallengesFrame.LineDown:Hide()
    Collection.SmallChallengesFrame.Art:Hide()
    Collection.SmallChallengesFrame.Texture:Hide()
    Collection.SmallChallengesFrame:CreateBackdrop("Default")

    -- Description Bars
    Collection.DescriptionMain.Art:SetTexture()
    S:HandleIcon(Collection.DescriptionMain.Icon)
    Collection.DescriptionMain.ArtSub:SetTexture()
    S:HandleIcon(Collection.DescriptionMain.IconSub)

    -- Season Points
    Collection.SeasonalPointsFrame_Total.BGText:Hide()
    Collection.SeasonalPointsFrame.BGText:Hide()
    Collection.SeasonalPointsFrame.BorderHighlight:Hide()
    Collection.SeasonalPointsFrame.Highlight:Hide()

    -- Season Reward Bar
    Collection.CosmeticReward.Art:SetTexture()
    S:HandleIcon(Collection.CosmeticReward.Icon)
end

-- Mythic Keystones
local function HandleKeystoneInfo()
    local KeystoneInfo = AscensionUI.MythicKeystone.KeystoneInfo

    KeystoneInfo:StripTextures(true)
    KeystoneInfo:CreateBackdrop("Transparent")
    KeystoneInfo.TitleText:FontTemplate(nil,12)
    
    --Close button
    S:HandleCloseButton(KeystoneInfo.CloseButton)

    --[[Previous Button
    S:HandleNextPrevButton(KeystoneInfo.LeftFramNextButton, "left")

    --Next Button
    S:HandleNextPrevButton(KeystoneInfo.LeftFramPrevButton, "right")
    ]]
    -- Dropdown
    S:HandleDropDownBox(KeystoneInfo.DungeonsDropDown, 190)
    --UIDropDownMenu_JustifyText(KeystoneInfo.DungeonsDropDown, "LEFT")
    --KeystoneInfo.DungeonsDropDown:SetSize(100,200)
    --KeystoneInfo.DungeonsDropDown:SetPoint("TOPRIGHT", KeystoneInfo, 1,-32)

    -- Scrollbar WHAT IS THIS CALLED???
    --S:HandleScrollBar(KeystoneInfo.RightScroll.scrollBar)

    --[[ Key buttons
    for i = 1, 8 do
        button = _G["AscensionUI.MythicKeystone.KeystoneInfo.RightScroll.Content.Button"..i]
        button:StripTextures(true)
    end
    ]]



end

-- Character Advancement
local function HandleCharacterAdvancement()
    local CharacterAdvancement = CA2

    CharacterAdvancement:StripTextures(true)
    CharacterAdvancement:CreateBackdrop("Transparent")
    CharacterAdvancement.TitleText:FontTemplate(nil,12)
    CharacterAdvancement.Art:StripTextures(true)
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame:StripTextures(true)

    -- Classes Buttons
    for i = 1, 10 do
        local button = _G["CA2.CharacterAdvancementMain.ClassButton"..i]

        -- Class Name
        _G[button:GetName().."Text"]:FontTemplate(nil,12)

        --[[ Class Icon -- Currently they have circle icons and it looks bad. I will leave there here
        button.Border:StripTextures(true)
        button.BGIcon:SetSize(44.1,44.1)
        button.Highlight_Add:StripTextures(true)
        button.Highlight:StripTextures(true)
        ]]

        -- Talent numbers
        button.TotalTalentsFrame:StripTextures(true)
        button.TotalTalentsFrame:CreateBackdrop("Default")
        button.TotalTalentsFrame:SetSize(20,20)
        -- Spell Numbers
        button.TotalSpellsFrame:StripTextures(true)
        button.TotalSpellsFrame:CreateBackdrop("Default")
        button.TotalSpellsFrame:SetSize(20,20)

        
    end

    -- Ability Essence
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:StripTextures(true)
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:CreateBackdrop("Transparent")
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:FontTemplate(nil, 10)

    -- Talent Essence
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:StripTextures(true)
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:CreateBackdrop("Transparent")
    CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:FontTemplate(nil, 10)

    -- Scroll of Unlearning
    CharacterAdvancement.Currency.ScrollButton.Text:FontTemplate(nil, 10)
    
    -- Reset All Abilities Button
    S:HandleButton(CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton)

    -- Reset All Talents Button
    S:HandleButton(CharacterAdvancement.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton)

    -- Search
    S:HandleEditBox(CharacterAdvancement.SearchBox)

    --Close button
    S:HandleCloseButton(CharacterAdvancement.CloseButton)

    --Scroll Bars
    S:HandleScrollBar(CharacterAdvancement.HSKnown.Scroll.scrollBar)
    --S:HandleScrollBar(CA2.Scroll_SpecList.ScrollBar)

    -- Class Talent Tabs
        -- Tab 1
    S:HandleTab(CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab:SetSize(100,30)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab:StripTextures(true)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab:SetPoint("TOPLEFT", 0, -15)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab:SetNormalTexture(nil)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab:SetHighlightTexture(nil)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab:SetCheckedTexture(nil)
            -- Total Spells
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:StripTextures(true)
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:CreateBackdrop("Default")
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:SetSize(20, 20)
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree1.Tab, "RIGHT", -24, 6)
    -- Tab 2
    S:HandleTab(CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab:SetSize(100,30)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab:StripTextures(true)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab:SetNormalTexture(nil)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab:SetHighlightTexture(nil)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab:SetCheckedTexture(nil)
        -- Total Spells
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:StripTextures(true)
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:CreateBackdrop("Default")
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:SetSize(20, 20)
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree2.Tab, "RIGHT", -24, 6)
    -- Tab 3
    S:HandleTab(CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab:SetSize(100,30)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab:StripTextures(true)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab:SetNormalTexture(nil)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab:SetHighlightTexture(nil)
    CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab:SetCheckedTexture(nil)
        -- Total Spells
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:StripTextures(true)
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:CreateBackdrop("Default")
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:SetSize(20, 20)
        CharacterAdvancement.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree3.Tab, "RIGHT", -24, 6)

    -- Abilities Sections
        -- Title
        CharacterAdvancement.CharacterAdvancementMain.Main.SpellsText:FontTemplate(nil, 24)
        CharacterAdvancement.CharacterAdvancementMain.Main.SpellsSubText:FontTemplate(nil, 12)

    -- Talents Section
        -- Title
        CharacterAdvancement.CharacterAdvancementMain.Main.TalentsText:FontTemplate(nil, 24)
        CharacterAdvancement.CharacterAdvancementMain.Main.TalentsSubText:FontTemplate(nil, 12)


    -- My Build and My Specs Tabs
    CharacterAdvancement.HeaderTabs:StripTextures(true)
    S:HandleTab(CharacterAdvancement.HeaderTabs.Tab1)
    CharacterAdvancement.HeaderTabs.Tab1:SetSize(60,30)
    S:HandleTab(CharacterAdvancement.HeaderTabs.Tab3)
    CharacterAdvancement.HeaderTabs.Tab3:SetSize(60,30)
    --CharacterAdvancement.HeaderTabsTab:StripTextures(true)



    -- Specializations (My Specs Section)
    CharacterAdvancement.SpecList:StripTextures(true)
        -- Top Button
        CA2.SpecList.SpecButton1:StripTextures(true)
        S:HandleButton(CA2.SpecList.SpecButton1)
        CA2.SpecList.SpecButton1:SetSize(225,45)
        CA2.SpecList.SpecButton1.Text:FontTemplate(nil, 14)
        -- The rest
        for i = 2, 13 do
            local specs = _G["CA2.SpecList.SpecButton"..i]
            specs:StripTextures(true)
            S:HandleButton(specs)
            specs.Text:FontTemplate(nil, 12)
            specs:SetSize(225,48)
            --specs.SpecIcon:SetSize(22,22)
            specs.SpecIcon:SetPoint("LEFT", 7, 1)
        end

    -- Known Spells
        --League Realm is differnet due to having Rarity Limits
  if C_Player:IsLeagueRealm() then
        for i = 1, 9 do
            local knownspell = _G["CA2.CA2.HSKnown.Content.SpellButton"..i]
            local buttonName = knownspell:GetName()
        
            knownspell.SpellName:FontTemplate(nil, 12)
            knownspell.BG:StripTextures(true)
            --knownspell.BG:CreateBackdrop("Transparent")
            knownspell.BG:SetSize(256,64)

            -- Rarity Limits
            CA2.RarityLimitsFrame:StripTextures(true)
            CA2.RarityLimitsFrame.FakeBorder:StripTextures(true)
            CA2.RarityLimitsFrame.FakeScroll:StripTextures(true)
            
            CA2.RarityLimitsFrame.Legendary:StripTextures(true)
            CA2.RarityLimitsFrame.Legendary:CreateBackdrop("Transparent")
            CA2.RarityLimitsFrame.Epic:StripTextures(true)
            CA2.RarityLimitsFrame.Epic:CreateBackdrop("Transparent")
            CA2.RarityLimitsFrame.Rare:StripTextures(true)
            CA2.RarityLimitsFrame.Rare:CreateBackdrop("Transparent")
            CA2.RarityLimitsFrame.Uncommon:StripTextures(true)
            CA2.RarityLimitsFrame.Uncommon:CreateBackdrop("Transparent")
        end
    else
        for i = 1, 11 do
            local knownspell = _G["CA2.CA2.HSKnown.Content.SpellButton"..i]
            local buttonName = knownspell:GetName()
        
            knownspell.SpellName:FontTemplate(nil, 12)
            knownspell.BG:StripTextures(true)
            --knownspell.BG:CreateBackdrop("Transparent")
            knownspell.BG:SetSize(256,64)
          end
  end

end

-- Heroic Architect
local function HandleBuildCreator()
    local BuildCreator = BuildCreator

    BuildCreator:StripTextures(true)
    BuildCreator:CreateBackdrop("Transparent")
    BuildCreator.TitleText:FontTemplate(nil,12)

    -- Search
    S:HandleEditBox(BuildCreator.SearchBox)

    -- Dropdown
    S:HandleDropDownBox(BuildCreator.RoleDropDown)
    UIDropDownMenu_JustifyText(BuildCreator.RoleDropDown, "LEFT")

    --Close button
    S:HandleCloseButton(BuildCreatorCloseButton)

    --Categories (Level Select)
    BuildCreator.Categories:StripTextures(true)
    BuildCreator.Categories.tabFeatured:StripTextures(true)
    S:HandleButton(BuildCreator.Categories.tabFeatured)
    S:HandleButton(BuildCreator.Categories.tabLevel60)
    S:HandleButton(BuildCreator.Categories.tabLevel60PvE)
    S:HandleButton(BuildCreator.Categories.tabLevel60PvP)
    S:HandleButton(BuildCreator.Categories.tabLevel70)
    S:HandleButton(BuildCreator.Categories.tabLevel70PvE)
    S:HandleButton(BuildCreator.Categories.tabLevel70PvP)
    S:HandleButton(BuildCreator.Categories.tabFresh)
    S:HandleButton(BuildCreatorLoadingStopButton)
       
    -- Leveling Frame (Build Select)
    BuildCreator.PreviewLeveling:StripTextures(true)
    BuildCreator.PreviewLeveling.bottomFrame:StripTextures(true)
    S:HandleButton(BuildCreator.PreviewLeveling.LearnAllButton)
    S:HandleButton(BuildCreator.PreviewLeveling.ActivateButton)
  --  S:HandleNextPrevButton(BuildCreator.PreviewLeveling.scrollFrame.ArrowL, "left")
  --  S:HandleNextPrevButton(BuildCreator.PreviewLeveling.scrollFrame.ArrowR, "right")
    BuildCreator.PreviewMax:StripTextures(true)
    BuildCreator.PreviewMax.bottomFrame:StripTextures(true)
    S:HandleButton(BuildCreator.PreviewMax.LearnAllButton)
    S:HandleButton(BuildCreator.PreviewMax.ActivateButton)
--    S:HandleCloseButton(BuildCreator.PreviewMaxBackButton)

    -- Mainscreen Choose Build Buttons
    --S:HandleButton(M.ManagerButton)

    -- Main Screen Scroll Bar
    --S:HandleScrollBar(BuildCreator.LevelingFrame.BuildCreator.LevelingFrame.HSBuilds.Scroll.scrollBar)

    -- Create Build Button
    S:HandleButton(BuildCreator.EditorButton)

    -- Refresh Build Button
    S:HandleButton(BuildCreator.LevelingFrame.RefreshButton)

end

S:AddCallbackForAddon("AscensionUI", "AscensionUI", function()
    if not E.private.addOnSkins.AscensionUI then return end

    HandleCollections()
    HandleVanity()
    HandleMysticEnchants()
    HandleSeasonCollection()
    HandleKeystoneInfo()
    HandleCharacterAdvancement()
    HandleBuildCreator()
end)

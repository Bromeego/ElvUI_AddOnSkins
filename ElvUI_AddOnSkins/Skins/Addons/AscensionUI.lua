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
            tab:GetDisabledTexture():SetTexture()
            tab.BG:SetTexture()
            S:HandleTab(tab)

            if i == 1 then
                tab:ClearAllPoints()
                tab:Point("TOPLEFT", frame, "BOTTOMLEFT", 20, 1)
            end
        end
    end
end

local function HandleVanity()
    local V = AscensionUI.Store
    V:StripTextures(true)
    V:CreateBackdrop("Transparent")

    -- Model Preview Frame
    V.ModelPreview.BGTex:Hide()
    V.ModelPreview_fake:CreateBackdrop("Default")

    -- Close Buttons
    S:HandleCloseButton(V.ModelPreview_fake.CloseButton)
    S:HandleCloseButton(V.CloseButton)

    -- Search Box
    S:HandleEditBox(V.SearchBox)

    -- Dropdown
    S:HandleDropDownBox(V.StoreTypeList, 180)
    UIDropDownMenu_JustifyText(V.StoreTypeList, "LEFT")

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

local function HandleMysticEnchants()
    local M = AscensionUI.MysticEnchant

    -- Main UI
    M:StripTextures(true)
    M:CreateBackdrop("Transparent")

    -- Control Frame
    S:HandleButton(M.ControlFrame.RollButton)
    S:HandleButton(M.ControlFrame.ExtractButton)
    M.ControlFrame.MoneyFrame:ClearAllPoints()
    M.ControlFrame.MoneyFrame:SetPoint("CENTER", M.ControlFrame, "CENTER", 0,0)
    M.ControlFrame.TokenFrame:ClearAllPoints()
    M.ControlFrame.TokenFrame:SetPoint("CENTER", M.ControlFrame, "CENTER", 0,0)
    M.ControlFrame.TokenFrame.TokenButton:ClearAllPoints()
    M.ControlFrame.TokenFrame.TokenButton:SetPoint("CENTER")
    M.ControlFrame.RollButton:ClearAllPoints()
    M.ControlFrame.RollButton:SetPoint("LEFT", M.ControlFrame, "LEFT", 0, 0)

    -- Paper Doll Slots
    for i = 1, 19 do
        local slot = M.PaperDoll["Slot"..i]
        S:HandleItemButton(slot)
        slot.BG:SetTexture()
        slot.Icon:SetTexCoord(unpack(E.TexCoords))
        slot.Icon:SetParent(slot.backdrop)
    end

    -- Enchant Frame
    M.EnchantFrame:StripTextures()
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

    -- Level Frame
    M.LevelFrame:Hide()
end

local function HandleSeasonCollection()
    local Collection = AscensionUI.SeasonalCollection

    Collection:StripTextures()
    Collection:CreateBackdrop("Transparent")

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

local function HandleKeystoneInfo()
    local KeystoneInfo = AscensionUI.MythicKeystone.KeystoneInfo

    KeystoneInfo:StripTextures()
    KeystoneInfo:CreateBackdrop("Transparent")

    KeystoneInfo.WeeklyInfo.BG:Hide()
end
S:AddCallbackForAddon("AscensionUI", "AscensionUI", function()
    if not E.private.addOnSkins.AscensionUI then return end

    HandleCollections()
    HandleVanity()
    HandleMysticEnchants()
    HandleSeasonCollection()
    HandleKeystoneInfo()
end)
-- script.lua
return function(UtilTab)
    UtilTab:CreateToggle({
        Name = "Auto Passar a Bomba",
        CurrentValue = false,
        Callback = function(state)
            getgenv().AutoPassBomba = state

            while getgenv().AutoPassBomba and task.wait(0.1) do
                local char = game.Players.LocalPlayer.Character
                if not char then continue end

                local bomb = char:FindFirstChild("Bomb") or char:FindFirstChildWhichIsA("Tool")
                if bomb then
                    local players = game:GetService("Players"):GetPlayers()
                    for _, plr in ipairs(players) do
                        if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PassBomb"):FireServer(plr)
                            break
                        end
                    end
                end
            end
        end,
    })
end

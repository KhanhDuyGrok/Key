-- ═══════════════════════════════════════════════════════════
--          MARUHUB KEY SYSTEM (Chỉ 3 dòng config)
-- ═══════════════════════════════════════════════════════════

-- THAY 3 DÒNG NÀY BẰNG THÔNG TIN NGƯỜI TA ĐÃ MỞ SẴN CHO BẠN
local Name     = "Duyle11's Application"        -- App Name
local Ownerid  = "39CimOd5rU" -- OwnerID
local Version  = "1.0"                     -- Version hiện tại

-- Lấy key từ executor
local License = tostring(getgenv().Key or "")
if License == "" or not License then
    game.Players.LocalPlayer:Kick("Thiếu key! Vui lòng nhập key hợp lệ.")
    return
end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Bước 1: Init app (không cần secret, không cần hwid)
local init = game:HttpGet("https://keyauth.win/api/1.2/?type=init&ver="..Version.."&name="..Name.."&ownerid="..Ownerid)
if not init or init == "KeyAuth_Invalid" then
    Player:Kick("Lỗi kết nối KeyAuth! App không tồn tại.")
    return
end

local initData = HttpService:JSONDecode(init)
if not initData.success then
    if initData.message == "invalidver" then
        Player:Kick("Script đã cũ! Vui lòng update phiên bản mới.")
    else
        Player:Kick("Lỗi khởi tạo: "..(initData.message or "Unknown"))
    end
    return
end

local sessionid = initData.sessionid

-- Bước 2: Check key (không cần hwid)
local login = game:HttpGet("https://keyauth.win/api/1.2/?type=license&key="..License.."&sessionid="..sessionid.."&name="..Name.."&ownerid="..Ownerid)
local result = HttpService:JSONDecode(login)

if not result.success then
    if result.message == "subscription_expired" then
        Player:Kick("Key đã hết hạn! Vui lòng gia hạn.")
    elseif result.message == "user_banned" then
        Player:Kick("Tài khoản của bạn đã bị BAN vĩnh viễn!")
    else
        Player:Kick("Key không hợp lệ!\nLỗi: "..(result.message or "Unknown"))
    end
    return
end

-- KEY HỢP LỆ → CHẠY SCRIPT CHÍNH
warn("Key hợp lệ! Chào "..result.info.username.." | Hết hạn: "..os.date("%d/%m/%Y", result.info.expiry))

-- DÁN TOÀN BỘ CODE CHẠY SCRIPT CỦA BẠN VÀO ĐÂY (giữ nguyên 100% như cũ)
-- ====================================================================

local scriptName = tostring(getgenv().NScript or "Unknown")

if scriptName == "MaruHub" then
    getgenv().NScript = "MaruHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "KaitunMaruDefault" then
    getgenv().NScript = "MaruHub"
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunFisch" then
    getgenv().NScript = "MaruHub"
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunGrowAGarden" then
    getgenv().NScript = "MaruHub"
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunBF" then
    getgenv().NScript = "MaruHub"
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "HoHoHub" then
    getgenv().NScript = "HohoHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

else
    Player:Kick("Không tìm thấy script: "..scriptName)
end

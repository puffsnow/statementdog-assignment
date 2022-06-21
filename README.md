# README

This is fork from statementdog assignment

# GOAL

- [x] 追蹤清單，包含以下功能：
    - [x] 建立追蹤清單
    - [x] 列出所有追蹤清單
    - [x] 編輯追蹤清單名稱
    - [x] 刪除追蹤清單
    - [x] 追蹤清單可以上下調整順序
- [x] 追蹤股票，需包含以下功能：
    - [x] 於任一個追蹤清單中，輸入股號建立「追蹤股票」
    - [x] 列出每個追蹤清單的所有「追蹤股票」
    - [x] 刪除特定「追蹤股票」
    - [x] （外加）追蹤股票可以上下調整順序
- [x] 可切換使用者

# Deploy
- 按照順序執行以下指令
```
# clone 專案到 local 環境
git clone git@github.com:puffsnow/statementdog-assignment.git
# 切換到專案資料夾
cd statementdog-assignment
# 基本安裝
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
yarn install
# 執行專案
bundle exec rails s
```

# 專案架構
- 未登入的狀態下，會進入到切換使用者的頁面，選擇使用者以後，才可以進行清單的操作
	- 每次切換時，會以使用者登入的情境考慮，給予他一個新的 token，並記錄在 session 做驗證
- 追蹤清單（detect_list）和股票（stock）之間是多對多的關聯，用（detect_item）記錄
- 追蹤清單（detect_list）的刪除，也會連帶刪除（detect_item）
- Swappable 是為了調整順序功能而建立的 module，model 只需要以下條件
	- 要有 position 的欄位
	- 要定義 swappable_parent，描述說是以什麼樣的群體在做排序
	- position 預設與 id 相同，這樣子在刪除和交換時，可以少考慮很多事情
	- 作業沒有要求但為了表示這個 module 是可以利用在任何 model 上的，所以也套用在 detect_item 上
	- 但 detect_item 也必須要避免 n + 1 的問題，所以為了 detect_list 頁要另外建立一個 scope，讓 detect_items 是排序後的結果
- 自定義了 UniversalError，來處理一些可預期的操作錯誤，並定義顯示的錯誤訊息以及行為
	- 後續可以考慮的：UniversalError 是否可以再做分類、像 RecordNotFound 這種 error，也該做處理（目前應該是會顯示 404）
- 寫測試的時機：
	- 主要著重在 controller / model 上，會想確認像是
		給的資料是否正確
		如果有邏輯處理，那結果是否符合預期
		操作錯誤的情境，是否有給予預期的回覆

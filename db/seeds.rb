Nickname.destroy_all

[
  ['Бармалей', 'Бармалея'],
  ['Вини-Пух', 'Вини-Пуха'],
  ['Пятачок', 'Пятачка'],
  ['Дюймовочка', 'Дюймовочки'],
  ['Незнайка', 'Незнайки'],
  ['Крокодил Гена ', 'Крокодила Гены'],
  ['Шапокляк', 'Шапокляк'],
  ['Чиполино', 'Чиполино'],
  ['Колобок', 'Колобка'],
  ['Соловей-Разбойник', 'Соловья-Разбойника'],
  ['Русалочка', 'Русалочки']
].each do |nickname|
  Nickname.where(genitive: nickname[0], accusative: nickname[1]).first_or_create
end

User.find_each do |u|
  u.update(nickname: Nickname.free.sample)
end
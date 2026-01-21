require 'open-uri'

puts "Creating authorized admin user..."
AdminUser.find_or_create_by!(email: 'naijeria@gmail.com')
puts "Authorized admin user created/verified"

puts "Creating sample diary entries..."

entries_data = [
  {
    date: Date.new(2026, 1, 15),
    body: "The morning light came through the window differently today. Not harsh, not demanding, but gentle — like it was asking permission to enter the room. I've been thinking about how we measure time in days when really we should measure it in moments of clarity. This morning was one of those moments.\n\nThe steam from my coffee rose in patterns that seemed to spell out words I almost understood. Almost. There's something about dawn that feels like the world's apology for yesterday's chaos.\n\nI've been keeping this journal for years now, and sometimes I wonder if anyone will ever read these words. Maybe that's not the point. Maybe the point is the telling itself — the act of taking these private thoughts and giving them form, giving them weight. The coffee is cold now. The sun is higher. The moment has passed, but it was here, and I was here for it."
  },
  {
    date: Date.new(2026, 1, 12),
    body: "Rain again. It seems like it's been raining for weeks, though I know that's not true. Memory exaggerates when it's lonely. I watched the drops hit the windowpane each racing to the bottom, each following its own path but all ending up in the same place.\n\nThere's probably a metaphor there, but I'm too tired to find it.\n\nSometimes I think about the person I used to be — the one who believed in forever, who collected promises like stones in a pocket. Now my pockets are empty and so is this room, except for the sound of rain and the weight of all these yesterdays. Tomorrow the sun will come out. It always does. But right now, right now is for rain."
  },
  {
    date: Date.new(2026, 1, 8),
    body: "Found an old photograph today — faded at the edges, curled like it had been holding something in for too long. I don't remember taking it, but there I am, smiling like I knew something the camera didn't. Maybe I did. Maybe we all know things we can't quite articulate, truths that live in the space between heartbeats.\n\nThe light in the photo is golden, the kind that only exists in late afternoon and memories. I've been trying to get back to that light, that feeling, but chasing the past is like trying to cup water in your hands. The tighter you hold, the more slips through your fingers.\n\nSo today I'm just letting it be. The photograph sits on my desk, and sometimes when I look at it, I think maybe that's enough."
  },
  {
    date: Date.new(2025, 12, 28),
    body: "Year's end always feels like standing between two mirrors — infinite reflections of who we were and who we're becoming. I walked through the city today and watched people rush past, each carrying their own stories, their own heartbreaks, their own quiet hopes. We're all just walking each other home, aren't we?\n\nTonight I'm making lists of things to leave behind: the anger that tasted like metal, the fear that dressed itself up as practicality, the love that was really just loneliness wearing someone else's coat.\n\nTomorrow I'll make new lists, of things to carry forward: the way light hits dust motes in the afternoon, the taste of good coffee, the certain knowledge that spring will come again. It always does."
  },
  {
    date: Date.new(2025, 12, 20),
    body: "The winter solstice. Longest night of the year. I stayed up until 3am watching the moon cross the sky, thinking about all the people throughout history who've done the same thing — standing in the darkness, waiting for the light to return. We're all just temporary arrangements of stardust, temporary patterns in the cosmic dark.\n\nMy neighbor's lights are still on. I wonder if they're also awake, also watching, also waiting. Maybe that's what community really is — not the big gatherings, not the planned events, but the quiet knowledge that somewhere nearby, someone else is also awake in the longest night, also believing in the coming dawn.\n\nTomorrow the days get longer. That's the promise. That's always been the promise."
  }
]

entries_data.each_with_index do |entry_data, index|
  entry = Entry.new(
    date: entry_data[:date],
    body: entry_data[:body]
  )

  begin
    image_url = "https://picsum.photos/seed/diary#{index}/800/600.jpg"
    file = URI.open(image_url)
    entry.image.attach(io: file, filename: "diary_#{index}.jpg", content_type: "image/jpeg")
    puts "Attached image for entry: #{entry.date}"
  rescue => e
    puts "Could not attach image for entry: #{e.message}"
  end

  entry.save!
  puts "Created entry: #{entry.date}"
end

puts "Created #{Entry.count} sample entries"

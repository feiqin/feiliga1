load "caculator.rb"
require 'net/http'

bot_token = "bojly6llqkddriuwd7k17d0g"

  def createTeams()
    teamsList = Array.new
    teamsList.push Team.new("FC Bayern Müchen", "40", 3)
    teamsList.push Team.new("Borussia Dortmund", "7", 1)
    teamsList.push Team.new("1899 Hoffenheim", "123", 11)
    teamsList.push Team.new("Werder Bremen", "134", 13)
    teamsList.push Team.new("Bor. Mönchengladbach", "87", 16)
    teamsList.push Team.new("1. FC Nürnberg", "79", 6)
    teamsList.push Team.new("1. FC Köln", "65", 10)
    teamsList.push Team.new("1. FC Kaiserslautern", "76", 7)
    teamsList.push Team.new("SC Freiburg", "112", 9)
    teamsList.push Team.new("Hannover 96", "55", 4)
    teamsList.push Team.new("Eintracht Frankfurt", "91", 17)
    teamsList.push Team.new("Hamburger SV", "100", 8)
    teamsList.push Team.new("FC Schalke 04", "9", 14)
    teamsList.push Team.new("1. FSV Mainz 05", "81", 5)
    teamsList.push Team.new("VfB Stuttgart", "16", 12)
    teamsList.push Team.new("FC St. Pauli", "98", 18)
    teamsList.push Team.new("Bayer Leverkusen", "6", 2)
    teamsList.push Team.new("VfL Wolfsburg", "131", 15)
    return teamsList
  end
teams = createTeams()

caculator = Caculator.new(teams)

matches = caculator.getMatches()
next_matches = Array.new
(0..matches.length-1).each do |i|
  line = matches[i]

  next_matches.push line.to_s.split("hostId",2)[1].split("id")[1].split("season")[0]

end

#next_matches = [10014, 10011, 10012,10013,10007,10008,10015,10009,10010]

http = Net::HTTP.new('botliga.de',80)

next_matches.each do |match_id|
  
  # insert smart voodoo calculations here
  result = "#{caculator.getResult(match_id)}"
  puts result

  # post your guess
  response, data = http.post('/api/guess',"match_id=#{match_id}&result=#{result}&token=#{bot_token}")

  # "201 Created" (initial guess) or "200 OK" (guess update)
  puts "#{response.code} #{data}"
end

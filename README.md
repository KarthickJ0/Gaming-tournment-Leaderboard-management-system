# Gaming-tournment-Leaderboard-management-system

# Gaming Tournament Database

This project is a structured SQL database for managing gaming tournaments. It includes tables for players, games, matches, leaderboards, prizes, and various stored procedures for retrieving and analyzing tournament data.

## Features
- **Player Management**: Stores player details including name, email, and join date.
- **Game Library**: Maintains records of games and their genres.
- **Match Tracking**: Logs matches between players with results and timestamps.
- **Leaderboard System**: Tracks rankings based on wins and total matches.
- **Prize Distribution**: Records tournament prize winnings for players.
- **Stored Procedures**: Provides various functions for data retrieval and tournament statistics.
- **Views**: Predefined queries for quick access to specific insights.

## Database Schema

### Tables
1. **Players**: Stores player details.
2. **Games**: Stores available games and their genres.
3. **Matches**: Tracks match results, including players and winners.
4. **Leaderboard**: Stores player rankings based on wins and matches played.
5. **Prizes**: Logs prize money distributed to players.

### Views
- `GamesWithoutMatches` - Lists games with no matches played.
- `PlayersMultiplePrizes` - Lists players with more than one prize.
- `PlayersWithoutWins` - Shows players who never won a match.
- `PlayerAveragePrize` - Displays average prize money won by each player.

## Stored Procedures
- `GetMatchDetails()` - Displays match details with player names and winners.
- `leaderboard_ranking()` - Retrieves the leaderboard rankings.
- `TOP5players_mostwins()` - Shows the top 5 players with the most wins.
- `Total_matchesplayed()` - Displays the total matches played per game.
- `Prize_money_disturbition()` - Shows total prize money won by each player.
- `Match_history_johndoe()` - Retrieves all matches played by a specific player.
- `Win_percentage_eachpalyer()` - Calculates and sorts players by win percentage.
- `top_3_players()` - Retrieves the top 3 players with the most prizes.
- `Retrieve_Match_Details()` - Fetches match details for a specific game.
- `GetLatestMatches()` - Retrieves the latest match results.

## Usage

### Running the SQL Script
1. Create the database:
   ```sql
   CREATE DATABASE GamingTournamentDB;
   USE GamingTournamentDB;
   ```
2. Run the SQL script in a MySQL-compatible environment.
3. Call stored procedures as needed:
   ```sql
   CALL GetMatchDetails();
   CALL leaderboard_ranking();
   ```

## Requirements
- MySQL or compatible SQL database.
- SQL client (e.g., MySQL Workbench)






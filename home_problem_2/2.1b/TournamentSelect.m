function iSelected = TournamentSelect(fitness, pTournament, tournamentSize)

    populationSize = size(fitness,1);
    
    tournamentIndices = zeros(tournamentSize,2);
    for i = 1:tournamentSize
       randIndex = 1 + fix(rand*populationSize);
       tournamentIndices(i,:) = [fitness(randIndex), randIndex];  
    end
    
    % sort the tournament indices based on fitness value
    tournamentIndices = sortrows(tournamentIndices);
    
    % Start with the highest index and decrement as long as the best
    % individual doesn't win or until we reach 1 (the worst individual)
    winnerIndex = tournamentSize;
    while rand > pTournament
        winnerIndex = winnerIndex - 1;
        if winnerIndex == 1
            break
        end
    end
    
    iSelected = tournamentIndices(winnerIndex,2);
    
end

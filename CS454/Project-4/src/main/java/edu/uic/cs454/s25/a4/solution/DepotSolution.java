package edu.uic.cs454.s25.a4.solution;

import java.util.HashSet;
import java.util.Set;

import edu.uic.cs454.s25.a4.Action;
import edu.uic.cs454.s25.a4.Depot;
import edu.uic.cs454.s25.a4.Result;

public class DepotSolution extends Depot<BusSolution, TicketSolution> {

    private Set<BusSolution> allBusses;

    public DepotSolution() {
        super();
        allBusses = new HashSet<BusSolution>();
    }

    @Override
    public BusSolution createBus(int capacity) {
        BusSolution newBus = new BusSolution(capacity);
        allBusses.add(newBus);
        return newBus;
    }

    @Override
    public TicketSolution issueTicket(int id) {
        return new TicketSolution(id);
    }

    @Override
    public boolean boardBus(BusSolution bus, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.ADD, tickets, result));
        return result.getResult(); 
    }

    @Override
    public boolean transferTickets(BusSolution from, BusSolution to, Set<TicketSolution> tickets) {
        // Remove the tickets from
        ResultSolution<Boolean> result = new ResultSolution<>();
        from.submitAction(new Action(Action.Direction.MOVE_OUT, tickets, result));
        if (result.getResult() == false) return false;

        // Add the tickets to
        result = new ResultSolution<>();
        to.submitAction(new Action(Action.Direction.MOVE_IN, tickets, result));
        if (result.getResult() == true) return true;        
        
        // If it gets here, boarding failed

        while (true) {
            // Add the tickets back to from
            result = new ResultSolution<>();
            from.submitAction(new Action(Action.Direction.MOVE_IN, tickets, result));
            if (result.getResult() == true) return false;

            // Or we can attempt boarding to again
            result = new ResultSolution<>();
            to.submitAction(new Action(Action.Direction.MOVE_IN, tickets, result));
            if (result.getResult() == true) return true;    
        }   
    }

    @Override
    public boolean useTickets(BusSolution bus, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.USED, tickets, result));
        return result.getResult(); 
    }

    @Override
    public boolean expireTickets(BusSolution bus, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.EXPIRED, tickets, result));
        return result.getResult(); 
    }

    @Override
    public Set<TicketSolution> getTickets() {
        Set<TicketSolution> tickets = new HashSet<>();
        for (BusSolution bus : allBusses) {
            ResultSolution<Set<TicketSolution>> result = new ResultSolution<>();
            bus.submitAction(new Action(Action.Direction.CONTENTS, Set.of(), result));
            tickets.addAll(result.getResult());
        }
        return tickets;
    }

    @Override
    public Set<TicketSolution> getTickets(BusSolution bus) {
        Set<TicketSolution> tickets = new HashSet<>();
        ResultSolution<Set<TicketSolution>> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.CONTENTS, Set.of(), result));
        tickets.addAll(result.getResult());
        return tickets;
    }

    @Override
    public Result<Boolean> boardBusAsync(BusSolution bus, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.ADD, tickets, result));
        return result;
    }

    @Override
    public Result<Boolean> transferTicketsAsync(BusSolution from, BusSolution to, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> moveOutResult = new ResultSolution<>();
        from.submitAction(new Action(Action.Direction.MOVE_OUT, tickets, moveOutResult));
    
        ResultSolution<Boolean> moveInResult = new ResultSolution<>();
        to.submitAction(new Action(Action.Direction.MOVE_IN, tickets, moveInResult));
    
        ResultSolution<Boolean> combinedResult = new ResultSolution<>() {
            @Override
            public Boolean getResult() {
                boolean fromSuccess = moveOutResult.getResult();
                boolean toSuccess = moveInResult.getResult();
                
                // both operations failed
                if (!fromSuccess && !toSuccess) return false;
                
                // passengers got off but failed to transfer
                // then put passengers back 
                while (fromSuccess && !toSuccess) {
                    ResultSolution<Boolean> restoreResult = new ResultSolution<>();
                    from.submitAction(new Action(Action.Direction.ADD, tickets, restoreResult));
                    if (restoreResult.getResult() == false) continue;
                    return false;
                }
                
                // passengers can't get off but added tickets to transfer
                // then remove tickets from "to"
                while (!fromSuccess && toSuccess) {
                    ResultSolution<Boolean> restoreResult = new ResultSolution<>();
                    to.submitAction(new Action(Action.Direction.MOVE_OUT, tickets, restoreResult));
                    if (restoreResult.getResult() == false) continue;
                    return false;
                }
                
                // Otherwise, transfer succeeded
                return true;
            }
        };
    
        return combinedResult;
    }

    @Override
    public Result<Boolean> useTicketsAsync(BusSolution bus, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.USED, tickets, result));
        return result;
    }

    @Override
    public Result<Boolean> expireTicketsAsync(BusSolution bus, Set<TicketSolution> tickets) {
        ResultSolution<Boolean> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.EXPIRED, tickets, result));
        return result;
    }

    @Override
    public Result<Set<TicketSolution>> getTicketsAsync() {
        Set<ResultSolution> allResults = new HashSet<>();
        for (BusSolution bus : allBusses) {
            ResultSolution<Set<TicketSolution>> result = new ResultSolution<>();
            bus.submitAction(new Action(Action.Direction.CONTENTS, Set.of(), result));
            allResults.add(result);
        }

        ResultSolution<Set<TicketSolution>> combined = new ResultSolution<>() {
            @Override
            public void setResult(Set<TicketSolution> result) {
                throw new Error("Not needed");
            }
            
            @Override
            public Set<TicketSolution> getResult() {
                Set<TicketSolution> res = new HashSet<>();
                for (ResultSolution<Set<TicketSolution>> it : allResults) {
                    res.addAll(it.getResult());
                }
                return res;
            }
        };
        return combined;
    }

    @Override
    public Result<Set<TicketSolution>> getTicketsAsync(BusSolution bus) {
        ResultSolution<Set<TicketSolution>> result = new ResultSolution<>();
        bus.submitAction(new Action(Action.Direction.CONTENTS, Set.of(), result));
        return result;
    }
        
}
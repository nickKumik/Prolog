% Code for an Expert System Shell: 
 
% See Bratko pages 353-356. 
%  
% The code below is for the expert system shell. This is the shell that you need to use 
% to write your own expert system; that is, your task will be to write the rules 
% which use the shell. Get the shell running in Prolog and test using Bratko’s 
% examples. 
% 
% Interaction with user and why and how explanation 
 
% Operators for easy to read rules. 
 
:-  op( 800, fx, if). 
:-  op( 700, xfx, then). 
:-  op( 300, xfy, or). 
:-  op( 200, xfy, and). 
:-  op( 800, xfx, <=). 
 
%%%% 
% Adam Wyner 
% Added the dynamic fact predicate as there were otherwise errors. 
% p. 351 in Bratko book. 
 
:- dynamic( fact/1). 
 
% is_true( P, Proof): Proof is a proof that P is true 
 
is_true( P, Proof)  :- 
   explore( P, Proof, []). 
 
%  explore( P, Proof, Trace): 
%     Proof is an explanation for P, Trace is a chain of rules between P's ancestor goals 
 
explore( P, P, _)  :- 
   fact( P).            %  P is a fact 
 
explore( P1 and P2, Proof1 and Proof2, Trace)  :-  !, 
   explore( P1, Proof1, Trace), 
   explore( P2, Proof2, Trace). 
 
explore( P1 or P2, Proof, Trace)  :-  !, 
   ( 
      explore( P1, Proof, Trace) 
      ; 
      explore( P2, Proof, Trace) 
   ). 
 
explore( P, P <= CondProof, Trace)  :- 
   if Cond then P,          %  A rule relevant to P  
   explore( Cond, CondProof, [ if Cond then P | Trace]). 
 
explore( P, Proof, Trace)  :- 
   askable( P),            % P may be asked of user 
   \+ fact( P),            % P not already known fact 
   \+ already_asked( P),                % P not yet asked of user 
   ask_user( P, Proof, Trace). 
 
ask_user( P, Proof, Trace)  :- 
   nl, write( 'Is it true:'), write( P), write(?), nl, write( 'Please answer yes, no, or why'), nl, 
   read( Answer), 
   process_answer( Answer, P, Proof, Trace).   % Process user's answer 
    
process_answer( yes, P, P  <= was_told, _)  :-  % User told P is true 
   asserta( fact(P)), 
   asserta( already_asked( P)). 
 
process_answer( no, P, _, _)  :- 
   asserta( already_asked( P)),       % Make sure not to ask again about P 
   fail.                        % User told P is not true 
 
process_answer( why, P, Proof, Trace)  :-    % User requested why-explanation 
   display_rule_chain( Trace, 0), nl, 
   ask_user( P, Proof, Trace).        % Ask about P again 
    
display_rule_chain( [], _). 
 
display_rule_chain( [if C then P | Rules], Indent)  :- 
   nl, write( 'To explore whether '), write( P), write(' is true, using rule:'),  
   nl, write( if C then P), 
   NextIndent is Indent + 2, 
   display_rule_chain(  Rules, NextIndent). 
 
:- dynamic already_asked/1. 

askable(no_symptoms_two_weeks).
askable(self_isolated_two_weeks).

askable(went_to_large_party).
askable(person_tested_positive_at_party).

askable(not_vaccinated).
askable(not_previously_contracted_coronaviruse).

askable(maybe_infected).
askable(may_not_imunne).

if maybe_infected and may_not_imunne then get_tested.
if no_symptoms_two_weeks and self_isolated_two_weeks then healthy.
if went_to_large_party and person_tested_positive_at_party then maybe_infected.
if not_vaccinated and not_previously_contracted_coronaviruse then may_not_imunne.

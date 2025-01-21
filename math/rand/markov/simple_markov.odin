package main

import "core:fmt"
import "core:math/rand"

// Illustrating a simple first-order markov chain, leveraging some Odin features.

State :: enum { Banana, Apple, Pear, Lime, Blueberry }

Transition_Matrix := [State][State]f64{
	.Banana     = {.Banana = 0.30, .Apple = 0.25, .Pear = 0.25, .Lime = 0.10, .Blueberry = 0.10},
	.Apple      = {.Banana = 0.10, .Apple = 0.25, .Pear = 0.32, .Lime = 0.13, .Blueberry = 0.20},
	.Pear       = {.Banana = 0.40, .Apple = 0.15, .Pear = 0.25, .Lime = 0.10, .Blueberry = 0.10},
	.Lime       = {.Banana = 0.05, .Apple = 0.05, .Pear = 0.25, .Lime = 0.35, .Blueberry = 0.30},
	.Blueberry  = {.Banana = 0.20, .Apple = 0.25, .Pear = 0.25, .Lime = 0.10, .Blueberry = 0.10},
}

main :: proc() {
	cur_state, prev_state: State

	for i in 1..=50 {
		cur_state = next_state(cur_state)
		fmt.printfln("State transition %v: %v -> %v", i, prev_state, cur_state)
		prev_state = cur_state
	}
}

next_state :: proc(cur_state: State) -> State {
	chance := rand.float64()
	accumulate: f64

	for s in State {
		accumulate += Transition_Matrix[cur_state][s]
		
		if chance < accumulate {
			return s
		}
	}

	return cur_state
}
# The Tower Idle - Death Defy

I play a mobile game called The Tower Idle.  In short, enemies will constantly attack your tower, and you must protect it with weapons and other power-ups.

One of these power-ups is called Death Defy.  Anytime your life would go to 0, Death Defy has a 30% chance to save you.  It can save you an unlimited number of times, luck allowing.

So the question is, what are the chances Death Defy will save you twice?  Three times?

Not that difficult of a question, probability-wise.

Your chances Death Defy will save you 0 times is 0.7

The chances it'll save you 1 time is 0.3 * 0.7 (saves you once, then you die).

The chances it'll save you 2 times is 0.3<sup>2</sup> * 0.7 (saves you twice, then you die)

And so on...

## Second Wind

This gets more complicated as more power-ups are upgraded.  There is an upgrade called Second Wind, which saves your life exactly 1 time.  And it only comes into play if Death Defy fails.

So you're guaranteed to survive your first deadly hit, and if you're lucky it won't use up your Second Wind.  So how does this affect our survival chances?

You have a 100% chance (1.00) to survive your first hit (0.7 chance of it using up your second wind, 0.3 chance you Death Defy it).

What are your chances of serviving 2 hits?  Well, if your first hit used up your Second Wind (0.7 chance of that) you have a 0.3 chance of surviving the second hit: 0.21 chance.  If you were lucky (0.3 chance) and you still have a Second Wind, then you have a 100% chance of surviving,  0.3 * 1 = 0.3 chance of that.  Either way you survive the second hit, so the probability of this is 0.21 + 0.3 = 0.51

What about surviving a 3rd hit?  If you haven't used your Second Wind yet, you have a 100% chance, but there's only a 0.3<sup>2</sup> chance of getting that far, so that's 0.09 chance.  If you've used your Second Wind, there's a 0.3 chance of surviving, but if you got there then you either used your Second Wind on the first hit (0.7 * 0.3 = 0.21 chance of that), or on your second hit (0.3 * 0.7 = 0.21 chance of that).  So your chances of surviving your 3rd hit are 0.09 + 0.21(0.3) + 0.21(0.3) = .216

See how the numbers get more complicated quickly?  Let's complicate it more.

## Energy Shield

There's ANOTHER power-up called Energy Shield.  It prevents all damage from any one hit.  It stores 1-3 charges (depending on upgrades), and it slowly recharges.  If the hit would kill you, Death Defy has a chance to prevent death first and save an Energy Shield charge.  If Death Defy fails, Energy Shield will take the hit and use up a charge.  If there are no charges remaining, Second Wind is activated.  If Second Wind has been used, then you die.

If it's a non-lethal hit, an Energy Shield charge is still used.  Luckily, at some point in the game bosses are the only enemies that manage to hit you, and they do not happen often, only every 88.25 seconds.  Meanwhile, Energy Shield takes 120 seconds to refill one charge.  So the bosses will eventually catch up to Energy Shield, with Death Defy sometimes saving a charge and Second Wind buying some recharge time when all charges are spent.  Notably, this gets very very complicated to calculate at this point.

And what's more fun than calculating?  Let's make a simulation!

# Simulation

Death Defy has a 0.3 chance of activating each hit.

Energy Shield can have either 1, 2, or 3 charges, with each charge having 120 energy (recovers 1 energy a second).  If it loses a charge, we subtract 120 energy.  It recovers 88.25 energy between hits, up to its maximum.

Second Wind is the last resort, and is set as a boolean.  Once it's set to `false` it's gone.
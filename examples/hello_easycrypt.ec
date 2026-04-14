require import Real Bool DBool.

type msg.
type cip.

(* Encrypt and decrypt operations. *)
op enc: msg -> cip.
op dec: cip -> msg.

(* Compute operations for the adversary. *)
op comp: cip -> bool.

module type Challenger = {
  proc encrypt(m:msg): cip
  proc decrypt(c:cip): msg
}.

module C:Challenger = {
  proc encrypt(m:msg): cip = {
    return enc(m);
  }
  proc decrypt(c:cip): msg = {
    return dec(c);
  }
}.

(* Similarly, we define an adversary *)
module type Adversary = {
  proc guess(c:cip): bool
}.
(* and a concrete instance of an adversary *)
module Adv:Adversary = {
  proc guess(c:cip): bool = {
    return comp(c);
  }
}.

module Game(C:Challenger, Adv:Adversary) = {
  proc ind_ror(): bool = {
    var m:msg;
    var c:cip;
    var b,b_adv:bool;
    b <$ {0,1}; (* Sample b uniformly at random *)
    if(b){
      (* Set m to be an authentic message *)
    } else {
      (* Set m to be a random string *)
    }
    c <@ C.encrypt(m);
    b_adv <@ Adv.guess(c);
    return (b_adv = b);
  }
}.

axiom ind_ror_pr_le1:
phoare [Game(C,Adv).ind_ror: true ==> res] <= 1%r.

lemma ind_ror_secure:
phoare [Game(C,Adv).ind_ror: true ==> res]<=(1%r/2%r).
proof.
    admit.
qed.

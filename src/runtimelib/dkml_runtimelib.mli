module Dkml_environment = Dkml_environment
module SystemConfig = Opam_context.SystemConfig

module Monadic_operators : sig
  val ( >>= ) : ('a, 'b) result -> ('a -> ('c, 'b) result) -> ('c, 'b) result
  val ( >>| ) : ('a -> 'b) -> ('a, 'c) result -> ('b, 'c) result
end

val int_parser : int Bos.OS.Env.parser
val get_msys2_dir_opt : (Fpath.t option, Rresult.R.msg) result lazy_t
val get_dkmlhome_dir_opt : (Fpath.t option, Rresult.R.msg) result lazy_t
val get_dkmlversion : (string, Rresult.R.msg) result lazy_t

type dkmlmode = Nativecode | Bytecode

val pp_dkmlmode : Format.formatter -> dkmlmode -> unit
val get_dkmlmode : (dkmlmode, Rresult.R.msg) result lazy_t
val association_list_of_sexp : Sexplib.Sexp.t -> (string * string) list

val get_opam_switch_prefix : (Fpath.t, Rresult.R.msg) result lazy_t
(** [get_opam_switch_prefix] is a lazy function that gets the OPAM_SWITCH_PREFIX environment variable.
    If OPAM_SWITCH_PREFIX is not found, then a fallback to <OPAMROOT>/playground is used instead. *)

val get_msys2_create_opam_switch_options : Fpath.t option -> string list

val init_system :
  f_temp_dir:(unit -> (Fpath.t, Rresult.R.msg) result) ->
  f_system_cfg:(unit -> (SystemConfig.t, Rresult.R.msg) result) ->
  (int, Rresult.R.msg) result
(** [init_system ~f_temp_dir ~f_system_cfg] initializes the system OCaml compiler, the opam root and the
    playground switch.

    The [f_temp_dir ()] function will be called to designate a temporary directory if the system is not
    initialized. The temporary directory and all of its parent directories will be created if needed.

    The [f_system_cfg ()] function will be called to collect the prereqs for creating a switch
    if the system is not initialized.

    If the system is already initialized, none of the possibly time-consuming functions are called.
      
    The result will be [Ok 0] if successful or [Ok code = Ok (128 + signal)] if the program was interrupted with
    a signal which you should immediately [exit code]. The result will otherwise be [Error msg] for an error. *)

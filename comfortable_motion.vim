"=============================================================================
" File: comfortable_motion.vim
" Author: Yuta Taniguchi (modified by Enrico Z. Borba)
" Created: 2016-10-02 (modified 2019-09-15)
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

let g:comfortable_motion_interval = 1000.0 / 60
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

" state of current motion
let s:comfortable_motion_state = {
\  "accel": 0.0,
\  "velocity": 0.0,
\  "delta": 0.0,
\}

function! s:signum(x)
  return a:x == 0 ? 0 : a:x / abs(a:x)
endfunction

function! s:truncate_toward_zero(x)
  return float2nr(a:x >= 0 ? floor(a:x) : ceil(a:x))
endfunction

function! s:scroll_tick(timer_id)
  let l:state = s:comfortable_motion_state

  let l:v_sign = s:signum(l:state.velocity)

  " l:hard_stop is if we've reached the top or bottom of the file and wish
  " to go beyond the file. this merits velocity being set to 0, and the
  " timer ending.
  let l:at_top_of_file = line(".") == 1
  let l:at_bot_of_file = line(".") == line("$")

  let l:hard_stop =
    \ (l:v_sign == -1 && l:at_top_of_file) ||
    \ (l:v_sign == 1 && l:at_bot_of_file)

  if !l:hard_stop && (abs(l:state.velocity) >= 1 || l:state.accel != 0)
    " unit conversion: ms -> s
    let l:dt = g:comfortable_motion_interval / 1000.0

    " f_friction = uN
    " f_drag = C_d * v^2
    let l:f_friction = g:comfortable_motion_friction
   " TODO: consider using pow(v, 2)
    let l:f_drag = g:comfortable_motion_air_drag * abs(l:state.velocity)

    let l:f_resistance = l:f_friction + l:f_drag


    " why do we decrease velocity by itself when the resistive force is large
    if l:f_resistance * l:dt > abs(l:state.velocity)
      let l:state.velocity += l:state.accel - l:state.velocity
    else
      let l:state.velocity += l:state.accel - (l:v_sign * l:f_resistance * l:dt)
    endif

    let l:state.delta += l:state.velocity * l:dt
    let l:state.accel = 0 " TODO: not sure if this is correct

    " scroll
    let l:int_delta = s:truncate_toward_zero(l:state.delta)
    let l:state.delta -= l:int_delta

    if l:int_delta > 0
      execute "normal! " . string(abs(l:int_delta)) . g:comfortable_motion_scroll_down_key
    elseif l:int_delta < 0
      execute "normal! " . string(abs(l:int_delta)) . g:comfortable_motion_scroll_up_key
    endif
    redraw
  else
    let l:state.velocity = 0
    let l:state.delta = 0
    " accel is already 0 here
    call timer_stop(s:timer_id)
    unlet s:timer_id
  endif
endfunction

function! comfortable_motion#flick(accel)
  if !exists('s:timer_id')
    " There is no thread, start one
    let l:interval = float2nr(round(g:comfortable_motion_interval))
    let s:timer_id = timer_start(l:interval, function("s:scroll_tick"), {'repeat': -1})
  endif
  let s:comfortable_motion_state.accel += a:accel
endfunction

nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>

nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

# import midi file 
# play
using Pkg 
Pkg.activate(".")
using MIDI
# load 
midi_data = load("bwv784.mid")
tpq = midi_data.tpq
tracks = midi_data.tracks
file_bsize = size(read("bwv784.mid"))
encoded_bsize = -1
tracks = [getnotes(track) for track in midi_data.tracks][2:3]
end_of_track = max([Int(track[end].position) + Int(track[end].duration) for track in tracks]...)
nmes = Int(ceil(end_of_track / tpq / 4))
mindur = Int(tpq / 4)
pitches = [Int(i.pitch) for track in tracks for i in track]
nnotes = length(pitches)
mean_notes =  Int(floor(nnotes / 25 / 2))
pitch_range = [min(pitches...), max(pitches...)]
function compute_sequence_length( nbNotes::Int, nmes::Int, nbTracks::Int, pitch_range::Int; mespos_exp=2,dur_exp=2)
    pitch_exp = Int(ceil(log(4, pitch_range)))
    mesnb_exp = Int(ceil(log(4, nmes * nbTracks)))
    note_codon_length = pitch_exp + mesnb_exp + mespos_exp + dur_exp
    dna_sequence_length = note_codon_length * nbNotes
    return note_codon_length, dna_sequence_length
end 
cod_l, dna_l = compute_sequence_length(nnotes, 25, 2, pitch_range[2] - pitch_range[1] )
add_mes = 25
ntracks = 2
cod_l, dna_l = compute_sequence_length(nnotes + add_mes * mean_notes, 25 + add_mes , ntracks, 80)
# extreme case Mahler symphony
ntot = 8 * 16 * 300
cod_l, dna_l = compute_sequence_length(ntot, 300 , 16, 80)

function translate_to_dna(notes)
end 
tracks[1]
for track in tracks 
    for event in track
        println(event)
    end 
end 
# parse 
# hash 
# reverse hash
# mutate 
# parse back to midi
# play 

function start(song) 

end

function update(elapsed) 

end

function beatHit(beat) 
	if beat == 8 then
		print('got hit the fuck out DAYUM HE NEED SUM MILK')
		playActorAnimation("dad","hit",false)
		
		shakeCam(0.01,0.3)
		setActorY(27.9,"carhit")
	end
end

function stepHit(step) 



end
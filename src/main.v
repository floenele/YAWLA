import os
import rand

//load file and split into array
fn filearray(filee string) []string {
	mut filef := os.read_lines(filee) or { panic(filee + ' not found') }
	return filef
}
fn shuffle(mut foo []string, mut bar []string) {
	for ii in 0 .. foo.len {
		cc := rand.int_in_range(ii, foo.len) or { panic('what the fuck did you do') }
		foo[ii], foo[cc] = foo[cc], foo[ii]
		bar[ii], bar[cc] = bar[cc], bar[ii]
	}
}
fn main() {
//load question/answer files
	questionsfile := os.input('enter questions file, each question has to be seperated by a *nix new line (\\n)\n')
	mut questions := filearray(questionsfile)
	origquestions := questions.clone()
	answersesfile := os.input('enter answerses file, each question has to be seperated by a *nix new line (\\n)\n')
        mut answerses := filearray(answersesfile)
	origanswerses := answerses.clone()
	yass := ['Y', 'y', 'yes', 'Yes', 'YES']
	nahh := ['N', 'n', 'no', 'No', 'NO']

//check for same amount of questions and answerses, returns error if not
	if questions.len != answerses.len {
		panic("Not the same amount of questions and answerses")
	}
	for {
		shuffle(mut questions, mut answerses)
		for questions.len != 0 {
			assert questions.len == answerses.len
			mut i := 0
			for {
				useranswerse := os.input('${questions[i]}\n')
				if useranswerse != answerses[i] {
					mut confirmationsucceed := false
					for confirmationsucceed == false {
						println(answerses[i])
						confirmation := os.input('Is the answerse correct ((Y)es/(N)o)? ')
						confirmationsucceed = true
						if confirmation in nahh {
							i++
						}
						else if confirmation in yass {
							questions.delete(i)
							answerses.delete(i)
						}
						else { confirmationsucceed = false } 
					}
				}
				else {	
					questions.delete(i)
					answerses.delete(i)
				}
				if i >= questions.len { i = 0 }
				if i == 0 { break } 
			}
		}
		if os.input('again? ') in nahh { break }
		else {
			answerses = origanswerses.clone()
			questions = origquestions.clone()
		}
	}
}	

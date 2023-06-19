import os
import rand
import term

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
	totalquestions := questions.len
	mut done := 0
	mut question := 1
//check for same amount of questions and answerses, returns error if not
	if questions.len != answerses.len {
		panic("Not the same amount of questions and answerses")
	}
	// spaghetti bolognese
	for {
		shuffle(mut questions, mut answerses)
		for questions.len != 0 {
			assert questions.len == answerses.len
			mut i := 0
			for {
				term.clear()
				println('question ${question}\t\t${done}/${totalquestions} done')
				useranswerse := os.input('${questions[i]}\n')
				if useranswerse != answerses[i] {
					println(answerses[i])
					confirmation := os.input('Is the answerse correct (y/N)? ')
					if confirmation in nahh { i++ }
					else if confirmation in yass {
						questions.delete(i)
						answerses.delete(i)
						done++
					}
					else { i++ } 
				}
				else {	
					questions.delete(i)
	 				answerses.delete(i)
					done++
				}
				if i >= questions.len { break }
				question++
			}
			question = 1
		}
		term.clear()
		println('${done}/${totalquestions}🥳')
		if os.input('again? ') in nahh { break }
		else {
			answerses = origanswerses.clone()
			questions = origquestions.clone()
			done = 0
		}
	}
}	

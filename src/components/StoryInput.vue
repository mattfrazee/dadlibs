<template>
  <div class="story-input-container" :class="{'adult': story.adult}">
    <div>
      <input :type="inputType"
             ref="answer"
             v-model="answer"
             v-on:keyup.enter="addAnswer"
             autocomplete="off"
             class="story-input">
      <p class="story-input-example">
        <span v-if="question.example">
          Example: {{ question.example }}
        </span>
      </p>
      <p class="story-input-title">
        {{ question.label }}
        <span class="italic normal-case font-normal text-lg block" v-if="question.paramLabel">({{ question.paramLabel }})</span>
      </p>
      <p class="story-input-description">
        {{ question.description }}
      </p>
      <story-button @click="addAnswer" :adult="story.adult" class="mb-8 block mx-auto w-full sm:w-3/4 md:w-1/2 lg:w-1/4">
        {{ !isLastQuestion ? 'Next' : 'Complete'}}
      </story-button>
      <div class="question-status">
        <p>Word {{ totalAnswers + 1 }} of {{ totalQuestions }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import StoryButton from "@/components/StoryButton";
export default {
  name: "StoryInput",
  components: { StoryButton },
  props: {
    answers: Array,
    questions: Object,
    story: Object,
  },
  methods: {
    addAnswer() {
      if (this.answer) {
        const focus = !this.isLastQuestion
        this.$emit('add-answer', this.answer)
        this.answer = null
        if (focus) {
          this.$nextTick(() => {
            this.$refs.answer.focus()
          })
        }
      }
    },
  },
  computed: {
    //TODO: change input type from question (handle iOS keyboard switch from qwerty to numeric)
    inputType() {
      return 'text'
      // return this.question.id === 'number' ? 'tel' : 'text'
    },
    isLastQuestion() {
      return this.answers.length === this.questions.length - 1
    },
    question() {
      return this.questions[this.answers.length]
    },
    totalQuestions() {
      return this.questions.length
    },
    totalAnswers() {
      return this.answers.length
    },
  },
  data() {
    return {
      answer: null
    }
  },
}
</script>

<style scoped>
.story-input-container {
  @apply grid grid-cols-1 min-h-full pt-16 items-center bg-blue-600 text-white
}

.story-input-container > div {
  @apply p-8
}

.adult {
  @apply bg-slate-800
}

.story-input {
  @apply p-2 text-3xl rounded-none outline-none ring-0 bg-transparent text-center text-white border-blue-300 border-b-2 block mx-auto w-full sm:w-3/4
}

.adult .story-input {
  @apply border-red-500
}

.story-input-title {
  @apply text-3xl uppercase font-bold text-center mt-6 mb-1
}

.story-input-description {
  @apply text-xs text-center mb-6 opacity-75
}

.story-input-example {
  @apply text-xs text-center italic mt-2 opacity-50
}

.question-status {
  @apply text-sm rounded-full mx-auto w-28 h-10 mb-4 flex text-center text-white items-center justify-center bg-blue-700
}

.adult .question-status {
  @apply bg-slate-700
}
</style>
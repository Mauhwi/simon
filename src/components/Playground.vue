<template>
  <div class="playground">
    <ul>
      <li
        v-on:click="checkAnswer(1); setAnimatedTile(1)"
        v-bind:class="[animatedTile == 1 ? 'active' : '', interactivityBlocked ? 'blocked' : '']"
        id="t1"
        class="tileRed" :v-model="round"
      ></li>
      <li
        v-on:click="checkAnswer(2); setAnimatedTile(2)"
        v-bind:class="[animatedTile == 2 ? 'active' : '', interactivityBlocked ? 'blocked' : '']"
        id="t2"
        class="tileGreen" :v-model="round"
      ></li>
      <li
        v-on:click="checkAnswer(3); setAnimatedTile(3)"
        v-bind:class="[animatedTile == 3 ? 'active' : '', interactivityBlocked ? 'blocked' : '']"
        id="t3"
        class="tileBlue" :v-model="round"
      ></li>
      <li
        v-on:click="checkAnswer(4); setAnimatedTile(4)"
        v-bind:class="[animatedTile == 4 ? 'active' : '', interactivityBlocked ? 'blocked' : '']"
        id="t4"
        class="tileYellow" :v-model="round"
      ></li>
    </ul>
    <div class="info">
      <button v-on:click="start">Старт</button>
      <h3 v-if="showResult">Пройдено уровней: {{sequence.length-1}}!</h3>
      <h3 v-if="!showResult">Цель игры: запомнить продемонстрированную 
        последовательность активации элементов поля и повторить ее. 
        С каждым успешным раундом количество элементов увеличивается</h3>
    </div>
  </div>
</template>

<script>
export default {
  name: "Playground",
  data() {
    return {
      interactivityBlocked: true,
      animatedTile: 0,
      currentNumber: 0,
      round: 0,
      sequence: [],
      showResult: false,
    };
  },
  methods: {

    start() {
      this.round = 0;
      this.showResult = false;
      this.sequence = [];
      this.setNewNumber();
      this.playSequence();
    },

    setNewNumber() {
      this.currentNumber = Math.floor(Math.random() * Math.floor(4) + 1);
      this.sequence.push(this.currentNumber);
    },

    checkAnswer(num) {
      if (num == this.currentNumber && this.round == this.sequence.length && this.round > 0) {
        this.round = 1;
        this.setNewNumber();
        this.playSequence();
      } else if (num == this.currentNumber && this.round == 0) {
        this.setNewNumber();
        this.playSequence();
        this.round++;
      } else if (num == this.currentNumber) {
        this.round++;
        this.currentNumber = this.sequence[this.round-1]; }
        else {
          this.showResult = true;
          this.interactivityBlocked = true;
        }
        
    },

    playSequence() {
      this.interactivityBlocked = true
      var i = 0;
      var interval = setInterval(() => {
        this.setAnimatedTile(this.sequence[i]);
        i++;
				if (i == this.sequence.length+1) {
          clearInterval(interval);
          this.currentNumber = this.sequence[0];
          this.animatedTile = 0;
          this.interactivityBlocked = false;
				} 
      }, 600);
    },

    setAnimatedTile(num) {
      this.animatedTile = num;
      this.playSound(num);
      setTimeout(() => {
        this.animatedTile = 0;
      }, 500)
    },

    playSound(num) {
      if (num == 1) {
        var sound = new Audio(require('../assets/audio/1.mp3'));
        sound.play();
      } else if (num == 2) {
         sound = new Audio(require('../assets/audio/2.mp3'));
        sound.play();
      } else if (num == 3) {
         sound = new Audio(require('../assets/audio/3.mp3'));
        sound.play();
      } else if (num == 4) {
         sound = new Audio(require('../assets/audio/4.mp3'));
        sound.play();
      }
    },
  }
}
</script>

<style lang="scss">
.playground {
  display: flex;
  align-content: center;
  justify-content: center;

  ul {
    border-radius: 8px;
    padding: 0;
    list-style: none;
    background-color: #333;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-evenly;
    align-content: space-evenly;
    width: 420px;
    height: 420px;

    li {
      border-radius: 8px;
      width: 180px;
      height: 180px;
      opacity: 0.6;
      cursor: pointer;
    }

    .tileRed {
      background-color: firebrick;
    }

    .tileBlue {
      background-color: royalblue;
    }

    .tileGreen {
      background-color: seagreen;
    }

    .tileYellow {
      background-color: moccasin;
    }

    li.active {
      opacity: 1;
      -webkit-box-shadow: 0px 0px 17px -7px rgba(255, 255, 255, 1);
      -moz-box-shadow: 0px 0px 17px -7px rgba(255, 255, 255, 1);
      box-shadow: 0px 0px 17px -7px rgba(255, 255, 255, 1);
    }
    li.blocked {
      pointer-events: none;
    }
  }

  .info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin-left: 28px;
    height: 420px;
    width: 280px;
    align-self: center;

    button {
      border: solid 1px #333;
      border-radius: 8px;
      margin-top: 8px;
      padding: 10px 42px;
    }

    h3 {
      text-align: start;
    }
  }
}
</style>

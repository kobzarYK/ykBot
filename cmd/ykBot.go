/*
Copyright © 2024 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	//TeleToken bot
	TeleToken = os.Getenv("TELE_TOKEN")
)

// ykBotCmd represents the ykBot command
var ykBotCmd = &cobra.Command{
	Use:     "ykBot",
	Aliases: []string{"start"},
	Short:   "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		//2.4 video
		//fmt.Println("ykBot called")

		//2.5 video
		fmt.Printf("ykBot %s started", appVersion)
		ykBot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})
		if err != nil {
			log.Fatalf("Please check TELE_TOKEN env variable. %s", err)
			return
		}
		ykBot.Handle(telebot.OnText, func(m telebot.Context) error {
			log.Print(m.Message().Payload, m.Text())
			payload := m.Message().Payload
			switch payload {
			case "hello":
				err = m.Send(fmt.Sprintf("Hello I'm YkBOT %s!", appVersion))

			}
			return err
		})
		ykBot.Start()
	},
}

func init() {
	rootCmd.AddCommand(ykBotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// ykBotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// ykBotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}

require "../src/tourmaline"

class EchoBot < Tourmaline::Bot
  include Tourmaline

  @[Command("echo")]
  def echo_command(ctx)
    ctx.reply(ctx.text)
  end
end

bot = EchoBot.new(ENV["API_KEY"])
bot.poll

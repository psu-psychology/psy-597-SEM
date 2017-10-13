library(ggplot2)
library(tidyr)
library(dplyr)
age <- seq(5, 20, .05)
linchange = 50 + 2*age
quadchange = 100 + 2*(age - 3) + -1.4*(age - 10)^2
decel <- (100 + exp(-0.2*(age))*1000 / 2)

df <- data.frame(age=age, linchange=linchange, quadchange = quadchange, decel=decel)

ggplot(df, aes(x=age, y=quadchange)) + geom_line()
ggplot(df, aes(x=age, y=decel)) + geom_line()

gg <- df %>% gather (key="form", value="dv", -age) %>%
  mutate(form=recode(form, linchange="Linear", quadchange="Quadratic", decel="Asymptotic decelerating"))

str(gg)
pdf("Forms_Of_Change.pdf", width=11, height=4)
ggplot(gg, aes(x=age, y=dv)) + geom_line(size=1.3) + facet_wrap(~form, scales="free_y") +
  theme_bw(base_size=23) + ylab("Measure of Interest") + xlab("Age")
dev.off()
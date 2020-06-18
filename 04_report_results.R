pacman::p_load(dplyr, data.table, ggplot2, fst, lubridate, rstan, broom, hrbrthemes)

fit_NHPP = readRDS('Fit/fit_NHPP.rds') %>% broom::tidy(conf.int = T, rhat = T, ess = T)
fit_JPLP = readRDS('Fit/fit_JPLP.rds') %>% broom::tidy(conf.int = T, rhat = T, ess = T)


comb_r0 = rbind(fit_NHPP %>% 
  filter(grepl('R0_true', term)) %>% 
  mutate(type = 'PLP'),
  fit_JPLP %>% 
    filter(grepl('R0_true', term)) %>% 
    mutate(type = 'JPLP')) %>% 
  mutate(type = factor(type, levels = c('PLP', 'JPLP')))
  

comb_r0 %>% 
  ggplot(aes(x=estimate, fill=type)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#404080", "#69b3a2")) +
  theme_ipsum() +
  labs(fill="")

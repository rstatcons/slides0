library(DiagrammeR)
numbofexp <- 3
numboflibs <- 10
numbofdevs <- 12

expnodes <- paste0("exp", seq_len(numbofexp))
explabels <- paste0("Эксперт", seq_len(numbofexp))
libnodes <- paste0("lib",  seq_len(numboflibs))
liblabels <- paste0("Расшир.",  seq_len(numboflibs))
devnodes <- paste0("dev", seq_len(numbofdevs))
devlabels <- paste0("Раз-чик", seq_len(numbofdevs))

nodes <-
  create_nodes(nodes = c("base", "board", expnodes, libnodes, devnodes),
               label = c("Ядро R", "Совет\nэкспертов", explabels, liblabels, devlabels),
               type = "lower",
               # style = "filled",
               color = "black",
               shape = c("circle", "rectangle", rep("triangle", numbofexp),
                         rep("circle", numboflibs)) #,
#                y = c(200, 100, rep(20, numbofexp), rep(300, numboflibs), rep(400, numbofdevs)),
#                x = 400
               )

devslibsedges <- list(from = sample(devnodes, numbofdevs * 2, replace = T),
                      to   = sample(libnodes, numbofdevs * 2, replace = T))

edges <-
  create_edges(from = c("board", expnodes, libnodes, devslibsedges[['from']]),
               to = c("base", rep("board", numbofexp), rep("base", numboflibs), devslibsedges[['to']]),
               relationship = "leading_to")

graph <- create_graph(nodes_df = nodes,
                      edges_df = edges,
                      graph_attrs = c("layout = neato",
                                      "overlap = false"),
                      node_attrs = c("fontsize = 7",
                                     "width = .8",
                                     "height = .8",
                                     "fixedsize = true"),
                      edge_attrs = c("arrowsize = 0.5"))

cat(render_graph(graph, output = "SVG"), file = "r_scheme.svg")


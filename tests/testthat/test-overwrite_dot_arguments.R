test_that("overwrite_dot_arguments correctly overwrites arguments", {
  # Test case 1: Basic functionality
  original_args <- list(a = 1, b = 2)
  result <- overwrite_dot_arguments(original_args, b = 3, c = 4)
  expect_equal(result$a, 1)
  expect_equal(result$b, 3)
  expect_equal(result$c, 4)

  # Test case 2: Overwriting with the same value
  result <- overwrite_dot_arguments(original_args, b = 2)
  expect_equal(result$a, 1)
  expect_equal(result$b, 2)
  expect_equal(result$c, NULL)

  # Test case 3: No overwriting when no matching names
  result <- overwrite_dot_arguments(original_args, d = 5)
  expect_equal(result$a, 1)
  expect_equal(result$b, 2)
  expect_equal(result$d, 5)
})

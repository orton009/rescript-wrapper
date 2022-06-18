let compose_left = (fn1, fn2) => {
  return function () {
    fn2(fn1(...arguments));
  };
};
